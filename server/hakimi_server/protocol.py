"""Codec for the self-describing protocol used by the original client.

The implementation follows ``base/protocol.lua`` from the reference APK.
It uses the runtime codebook exported from ``db/describe.dat`` and the full
type definitions extracted from ``Net/Msg*.lua``.
"""

from __future__ import annotations

from dataclasses import dataclass
import json
from pathlib import Path
import struct
from typing import Any


OBJECT = 0xF0
STRING = 0xE0
ARRAY = 0xD0
MAP = 0xC0
BYTE_ARRAY = 0xB0
DATE_TIME = 0xA0
COLLECTION = 0x90
ENUM = 0x50
BOOLEAN = 0x20
NUMBER = 0x10
NULL = 0x01

TYPE_MASK = 0xF0
SIGNAL_MASK = 0x07
NEGATIVE_MASK = 0x08
EXTENDED_MASK = 0x80

INT32 = 1
INT64 = 2
FLOAT = 3
DOUBLE = 4


# A few shipped command signatures retain historical Java package names,
# while describe.dat and the actual model definitions use these names.
TYPE_ALIASES = {
    "com.eyu.mt.module.gift.manager.SpRecord":
        "com.eyu.mt.module.gift.model.SpRecordVo",
    "com.eyu.mt.test.fight.model.BattleInfo":
        "com.eyu.mt.module.fight.model.BattleInfo",
    "com.eyu.mt.test.fight.model.FightReport":
        "com.eyu.mt.module.fight.model.FightReport",
}


class ProtocolError(ValueError):
    pass


def _args(type_info: dict[str, Any]) -> list[Any]:
    args = type_info.get("args")
    if isinstance(args, list):
        return args
    return [type_info.get("arg")]


class Schema:
    def __init__(self, schema: dict[str, Any], codebook: dict[str, Any]):
        self.modules = schema["modules"]
        self.types = schema["types_full"]
        self.objects_by_name = codebook["object"]
        self.enums_by_name = codebook["enum"]
        for alias, canonical in TYPE_ALIASES.items():
            if canonical in self.types:
                self.types[alias] = self.types[canonical]
            if canonical in self.objects_by_name:
                self.objects_by_name[alias] = self.objects_by_name[canonical]
            if canonical in self.enums_by_name:
                self.enums_by_name[alias] = self.enums_by_name[canonical]
        self.objects_by_code = {
            int(info["code"]): info for info in self.objects_by_name.values()
        }
        self.enums_by_code = {
            int(info["code"]): info for info in self.enums_by_name.values()
        }
        self.modules_by_id = {
            int(module["mod"]): module
            for module in self.modules.values()
            if module.get("mod") is not None and isinstance(module.get("cmd"), dict)
        }

    @classmethod
    def load(cls, schema_path: Path, codebook_path: Path) -> "Schema":
        return cls(
            json.loads(schema_path.read_text(encoding="utf-8")),
            json.loads(codebook_path.read_text(encoding="utf-8")),
        )

    def command(self, mod: int, cmd: int) -> tuple[str, list[Any]]:
        module = self.modules_by_id.get(mod)
        if module is None:
            raise ProtocolError(f"unknown module {mod}")
        for name, definition in module["cmd"].items():
            if int(definition[0]) == cmd:
                return name, definition
        raise ProtocolError(f"unknown command {mod}:{cmd}")

    def request_type(self, mod: int, cmd: int) -> Any:
        return self.command(mod, cmd)[1][1]

    def response_type(self, mod: int, cmd: int) -> Any:
        definition = self.command(mod, cmd)[1]
        return definition[2] if len(definition) > 2 else {}


class Writer:
    def __init__(self, schema: Schema):
        self.schema = schema
        self.buffer = bytearray()
        self.string_refs: dict[bytes, int] = {}
        self.object_refs: dict[int, int] = {}

    def encode(self, type_info: Any, value: Any) -> bytes:
        self._write(type_info, value)
        return bytes(self.buffer)

    def _byte(self, value: int) -> None:
        self.buffer.append(value & 0xFF)

    def _varint(self, value: int) -> None:
        value = int(value)
        if value < 0:
            raise ProtocolError("varint cannot be negative")
        if value < EXTENDED_MASK:
            self._byte(value)
            return
        count = max(1, (value.bit_length() + 7) // 8)
        if count > 8:
            raise ProtocolError("varint exceeds 8 bytes")
        self._byte(EXTENDED_MASK | count)
        self.buffer.extend(value.to_bytes(count, "big"))

    def _ref(self, value: Any) -> int | None:
        return self.object_refs.get(id(value))

    def _remember(self, value: Any) -> None:
        self.object_refs[id(value)] = len(self.object_refs) + 1

    def _write(self, type_info: Any, value: Any) -> None:
        if value is None:
            self._byte(NULL)
            return

        if isinstance(type_info, str):
            definition = self.schema.types.get(type_info)
            if definition is None:
                raise ProtocolError(f"undefined type {type_info}")
            if isinstance(definition, dict) and definition.get("__call") == "enum":
                self._write_enum(type_info, value)
            elif isinstance(definition, dict) and definition.get("__call") == "const":
                self._write_number(value)
            else:
                self._write_object(type_info, definition, value)
            return

        if isinstance(type_info, dict) and "__ref" in type_info:
            primitive = type_info["__ref"]
            if primitive == "bool":
                self._byte(BOOLEAN | (1 if value else 0))
            elif primitive in ("int", "double"):
                self._write_number(value)
            elif primitive == "long":
                if isinstance(value, (bytes, bytearray)):
                    self.buffer.extend(value)
                elif isinstance(value, (int, float)) and not isinstance(value, bool):
                    # Java Long fields are not all entity IDs.  The official
                    # server emits small counters such as player.exp as an
                    # ordinary numeric value; the self-describing reader then
                    # returns a Lua number.  Entity IDs retain their encoded
                    # byte representation so the client can compare them
                    # without losing 64-bit precision.
                    self._write_number(value)
                else:
                    raise ProtocolError("long values must be numeric or use the client's encoded byte form")
            elif primitive == "date":
                self._byte(DATE_TIME)
                self._varint(int(value) // 1000)
            elif primitive == "string":
                self._write_string(value)
            elif primitive == "bytearray":
                raw = bytes(value)
                self._byte(BYTE_ARRAY)
                self._varint(len(raw))
                self.buffer.extend(raw)
            elif primitive == "object":
                self._write_dynamic(value)
            else:
                raise ProtocolError(f"unknown primitive {primitive}")
            return

        if isinstance(type_info, dict) and "__call" in type_info:
            call = type_info["__call"]
            args = _args(type_info)
            if call in ("array", "set"):
                self._write_array(args[-1], value)
            elif call == "map":
                if len(args) != 2:
                    raise ProtocolError("map requires key and value types")
                self._write_typed_map(args[0], args[1], value)
            elif call == "enum":
                raise ProtocolError("anonymous enum cannot be encoded")
            elif call == "const":
                self._write_number(value)
            else:
                raise ProtocolError(f"unknown type constructor {call}")
            return

        if isinstance(type_info, dict):
            self._write_struct_map(type_info, value)
            return
        raise ProtocolError(f"unsupported type expression {type_info!r}")

    def _write_dynamic(self, value: Any) -> None:
        """Encode the protocol's self-describing ``object`` fields.

        Reward/cost contents are deliberately untyped in the shipped schema.
        Their actual payloads are small maps containing numbers and dates.
        """
        if value is None:
            self._byte(NULL)
        elif isinstance(value, bool):
            self._byte(BOOLEAN | (1 if value else 0))
        elif isinstance(value, (int, float)):
            # Untyped JSON-style contents use Lua numbers even for millisecond
            # timestamps. INT64 is reserved by this client for opaque entity
            # IDs and is decoded to a byte string, so large dynamic values must
            # travel as doubles.
            if isinstance(value, int) and abs(value) >= 2_147_483_647:
                self._byte(NUMBER | (NEGATIVE_MASK if value < 0 else 0) | DOUBLE)
                self.buffer.extend(struct.pack(">d", float(abs(value))))
            else:
                self._write_number(value)
        elif isinstance(value, str):
            self._write_string(value)
        elif isinstance(value, (bytes, bytearray)):
            raw = bytes(value)
            self._byte(BYTE_ARRAY)
            self._varint(len(raw))
            self.buffer.extend(raw)
        elif isinstance(value, (list, tuple)):
            if not self._start_container(ARRAY, value):
                return
            self._varint(len(value))
            for item in value:
                self._write_dynamic(item)
        elif isinstance(value, dict):
            if not self._start_container(MAP, value):
                return
            self._varint(len(value))
            for key, item in value.items():
                self._write_dynamic(key)
                self._write_dynamic(item)
        else:
            raise ProtocolError(f"unsupported dynamic object value {type(value).__name__}")

    def _write_number(self, value: Any) -> None:
        if isinstance(value, bool) or not isinstance(value, (int, float)):
            raise ProtocolError(f"number expected, got {type(value).__name__}")
        negative = value < 0
        absolute = abs(value)
        if isinstance(value, float) and not value.is_integer():
            self._byte(NUMBER | (NEGATIVE_MASK if negative else 0) | DOUBLE)
            self.buffer.extend(struct.pack(">d", float(absolute)))
            return
        integer = int(absolute)
        kind = INT32 if integer < 2_147_483_647 else INT64
        self._byte(NUMBER | (NEGATIVE_MASK if negative else 0) | kind)
        self._varint(integer)

    def _write_string(self, value: Any) -> None:
        if not isinstance(value, str):
            raise ProtocolError(f"string expected, got {type(value).__name__}")
        raw = value.encode("utf-8")
        ref = self.string_refs.get(raw)
        if ref is not None:
            self._byte(STRING | 1)
            self._varint(ref)
            return
        self.string_refs[raw] = len(self.string_refs) + 1
        self._byte(STRING)
        self._varint(len(raw))
        self.buffer.extend(raw)

    def _write_enum(self, type_name: str, value: Any) -> None:
        info = self.schema.enums_by_name.get(type_name)
        if info is None:
            raise ProtocolError(f"enum code missing for {type_name}")
        self._byte(ENUM)
        self._varint(int(info["code"]))
        self._varint(int(value))

    def _start_container(self, flag: int, value: Any) -> bool:
        ref = self._ref(value)
        if ref is not None:
            self._byte(flag | 1)
            self._varint(ref)
            return False
        self._remember(value)
        self._byte(flag)
        return True

    def _write_array(self, item_type: Any, value: Any) -> None:
        if not isinstance(value, (list, tuple)):
            raise ProtocolError("array expected")
        if not self._start_container(ARRAY, value):
            return
        self._varint(len(value))
        for item in value:
            self._write(item_type, item)

    def _write_typed_map(self, key_type: Any, value_type: Any, value: Any) -> None:
        if not isinstance(value, dict):
            raise ProtocolError("map expected")
        if not self._start_container(MAP, value):
            return
        self._varint(len(value))
        for key, item in value.items():
            self._write(key_type, key)
            self._write(value_type, item)

    def _write_struct_map(self, fields: dict[str, Any], value: Any) -> None:
        if not isinstance(value, dict):
            raise ProtocolError("object-shaped map expected")
        if not fields:
            return
        if not self._start_container(MAP, value):
            return
        self._varint(len(fields))
        for field, field_type in fields.items():
            self._write({"__ref": "string"}, field)
            self._write(field_type, value.get(field))

    def _write_object(self, type_name: str, fields: Any, value: Any) -> None:
        if not isinstance(fields, dict) or "__call" in fields:
            raise ProtocolError(f"{type_name} is not an object type")
        if not isinstance(value, dict):
            raise ProtocolError(f"object expected for {type_name}")
        info = self.schema.objects_by_name.get(type_name)
        if info is None:
            # The shipped describe.dat omits several newer model classes
            # declared in MsgGift.  The Lua reader accepts self-describing
            # maps at these positions, so encode their declared fields as a
            # map instead of inventing a type code the client cannot decode.
            self._write_struct_map(fields, value)
            return
        if not self._start_container(OBJECT, value):
            return
        ordered_fields = info["fields"]
        self._varint(int(info["code"]))
        self._byte(len(ordered_fields))
        for field in ordered_fields:
            self._write(fields.get(field), value.get(field))


class Reader:
    def __init__(self, schema: Schema, payload: bytes):
        self.schema = schema
        self.payload = payload
        self.offset = 0
        self.string_refs: list[str] = []
        self.object_refs: list[Any] = []

    def decode(self) -> Any:
        result = self._read()
        if self.offset != len(self.payload):
            raise ProtocolError(f"trailing protocol bytes: {len(self.payload) - self.offset}")
        return result

    def _bytes(self, size: int) -> bytes:
        end = self.offset + size
        if end > len(self.payload):
            raise ProtocolError("truncated protocol value")
        value = self.payload[self.offset:end]
        self.offset = end
        return value

    def _byte(self) -> int:
        return self._bytes(1)[0]

    def _peek(self) -> int:
        if self.offset >= len(self.payload):
            raise ProtocolError("truncated protocol value")
        return self.payload[self.offset]

    def _varint(self) -> int:
        tag = self._byte()
        if tag < EXTENDED_MASK:
            return tag
        count = tag & SIGNAL_MASK
        if count == 0:
            raise ProtocolError("invalid extended varint")
        return int.from_bytes(self._bytes(count), "big")

    def _read(self) -> Any:
        flag = self._peek()
        kind = flag & TYPE_MASK
        if flag == NULL:
            self._byte()
            return None
        if kind == BOOLEAN:
            value = self._byte() & SIGNAL_MASK
            if value not in (0, 1):
                raise ProtocolError(f"invalid boolean signal {value}")
            return bool(value)
        if kind == NUMBER:
            return self._read_number()
        if kind == DATE_TIME:
            self._byte()
            return self._varint() * 1000
        if kind == STRING:
            return self._read_string()
        if kind == BYTE_ARRAY:
            self._byte()
            return self._bytes(self._varint())
        if kind == ENUM:
            self._byte()
            self._varint()  # enum code; retained in the runtime codebook
            return self._varint()
        if kind in (ARRAY, COLLECTION):
            return self._read_array()
        if kind == MAP:
            return self._read_map()
        if kind == OBJECT:
            return self._read_object()
        raise ProtocolError(f"unknown value flag 0x{flag:02x}")

    def _read_number(self) -> Any:
        flag = self._byte()
        sign = -1 if flag & NEGATIVE_MASK else 1
        number_type = flag & SIGNAL_MASK
        if number_type in (INT32, INT64):
            value: Any = self._varint()
            if number_type == INT64:
                # The Lua client exposes long IDs as their encoded byte form.
                encoded = bytes((flag,)) + self.payload[self.offset - self._encoded_varint_size(value):self.offset]
                return encoded
            return sign * value
        if number_type == FLOAT:
            return sign * struct.unpack(">f", self._bytes(4))[0]
        if number_type == DOUBLE:
            return sign * struct.unpack(">d", self._bytes(8))[0]
        raise ProtocolError(f"unknown number type {number_type}")

    @staticmethod
    def _encoded_varint_size(value: int) -> int:
        return 1 if value < EXTENDED_MASK else 1 + max(1, (value.bit_length() + 7) // 8)

    def _read_string(self) -> str:
        flag = self._byte()
        tag = flag & SIGNAL_MASK
        if tag == 1:
            index = self._varint()
            try:
                return self.string_refs[index - 1]
            except IndexError as exc:
                raise ProtocolError(f"invalid string reference {index}") from exc
        if tag not in (0, 2):
            raise ProtocolError(f"invalid string signal {tag}")
        value = self._bytes(self._varint()).decode("utf-8")
        self.string_refs.append(value)
        return value

    def _read_ref(self, flag: int) -> Any | None:
        if flag & SIGNAL_MASK != 1:
            return None
        index = self._varint()
        try:
            return self.object_refs[index - 1]
        except IndexError as exc:
            raise ProtocolError(f"invalid object reference {index}") from exc

    def _read_array(self) -> Any:
        flag = self._byte()
        ref = self._read_ref(flag)
        if ref is not None:
            return ref
        value: list[Any] = []
        self.object_refs.append(value)
        for _ in range(self._varint()):
            value.append(self._read())
        return value

    def _read_map(self) -> Any:
        flag = self._byte()
        ref = self._read_ref(flag)
        if ref is not None:
            return ref
        value: dict[Any, Any] = {}
        self.object_refs.append(value)
        for _ in range(self._varint()):
            key = self._read()
            item = self._read()
            value[key] = item
        return value

    def _read_object(self) -> Any:
        flag = self._byte()
        ref = self._read_ref(flag)
        if ref is not None:
            return ref
        value: dict[str, Any] = {}
        self.object_refs.append(value)
        code = self._varint()
        info = self.schema.objects_by_code.get(code)
        if info is None:
            raise ProtocolError(f"unknown object code {code}")
        field_count = self._varint()
        fields = info["fields"]
        if field_count > len(fields):
            raise ProtocolError(f"object {info['name']} has {field_count} fields; codebook has {len(fields)}")
        for field in fields[:field_count]:
            value[field] = self._read()
        value["__type__"] = info["name"]
        return value


def encode(schema: Schema, type_info: Any, value: Any) -> bytes:
    return Writer(schema).encode(type_info, value)


def decode(schema: Schema, payload: bytes) -> Any:
    return Reader(schema, payload).decode()


@dataclass(slots=True)
class ApplicationPacket:
    encoding: int
    status: int
    order: int
    identity: int
    cmd: int
    mod: int
    content: bytes
    trailing: bytes = b""


HEADER_SIZE = 30
RESPONSE_STATUS = 1


def unpack_application_packet(data: bytes) -> ApplicationPacket:
    if len(data) < HEADER_SIZE + 4:
        raise ProtocolError("application packet is too short")
    header_size, encoding, status, order, identity, cmd, mod = struct.unpack_from(
        ">IBIQQiB", data, 0
    )
    if header_size < HEADER_SIZE or header_size > len(data) - 4:
        raise ProtocolError(f"invalid header size {header_size}")
    content_size = struct.unpack_from(">I", data, header_size)[0]
    if content_size < 4:
        raise ProtocolError(f"invalid content size {content_size}")
    content_end = header_size + content_size
    if content_end > len(data):
        raise ProtocolError("truncated content block")
    return ApplicationPacket(
        encoding=encoding,
        status=status,
        order=order,
        identity=identity,
        cmd=cmd,
        mod=mod,
        content=data[header_size + 4:content_end],
        trailing=data[content_end:],
    )


def pack_application_packet(packet: ApplicationPacket) -> bytes:
    header = struct.pack(
        ">IBIQQiB",
        HEADER_SIZE,
        packet.encoding,
        packet.status,
        packet.order,
        packet.identity,
        packet.cmd,
        packet.mod,
    )
    content = struct.pack(">I", 4 + len(packet.content)) + packet.content
    return header + content + packet.trailing
