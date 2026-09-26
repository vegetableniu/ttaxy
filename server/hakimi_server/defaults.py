"""Typed defaults for explicit response builders.

These defaults are only a construction aid.  Handlers still have to opt in
and override every field whose game meaning is not the natural empty value.
Unknown commands never receive an automatic success response.
"""

from __future__ import annotations

from typing import Any

from .protocol import ProtocolError, Schema, _args


def long_id(value: int) -> bytes:
    """Encode an integer in the byte representation exposed by Lua ``long``."""
    value = int(value)
    flag = 0x1A if value < 0 else 0x12
    absolute = abs(value)
    if absolute == 0:
        return bytes((flag, 0))
    size = max(1, (absolute.bit_length() + 7) // 8)
    return bytes((flag, 0x80 | size)) + absolute.to_bytes(size, "big")


def default_value(schema: Schema, type_info: Any, stack: frozenset[str] = frozenset()) -> Any:
    if isinstance(type_info, str):
        definition = schema.types.get(type_info)
        if definition is None:
            return None
        if isinstance(definition, dict) and definition.get("__call") in ("enum", "const"):
            return 0
        if type_info in stack:
            return None
        wire = schema.objects_by_name.get(type_info)
        names = wire["fields"] if wire else list(definition)
        return {
            field: default_value(
                schema,
                definition.get(field, definition.get("is" + field[:1].upper() + field[1:])),
                stack | {type_info},
            )
            for field in names
        }
    if isinstance(type_info, dict) and "__ref" in type_info:
        primitive = type_info["__ref"]
        if primitive == "bool":
            return False
        if primitive in ("int", "double", "date"):
            return 0
        if primitive == "long":
            return long_id(0)
        if primitive == "string":
            return ""
        if primitive == "bytearray":
            return b""
        if primitive == "object":
            return None
        raise ProtocolError(f"unknown primitive {primitive}")
    if isinstance(type_info, dict) and "__call" in type_info:
        call = type_info["__call"]
        if call in ("array", "set"):
            return []
        if call == "map":
            return {}
        if call in ("enum", "const"):
            return 0
        raise ProtocolError(f"unknown type constructor {call}: {_args(type_info)!r}")
    if isinstance(type_info, dict):
        return {
            field: default_value(schema, field_type, stack)
            for field, field_type in type_info.items()
        }
    return None


def default_object(schema: Schema, type_name: str) -> dict[str, Any]:
    value = default_value(schema, type_name)
    if not isinstance(value, dict):
        raise ProtocolError(f"{type_name} is not an object")
    return value

