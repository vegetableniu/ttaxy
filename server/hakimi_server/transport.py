"""Native CNetMgr TCP envelope used outside the Lua application packet."""

from __future__ import annotations

from dataclasses import dataclass
import struct

from .protocol import ProtocolError


PACKET_ID = 0xFFFFFFFF


def bp_hash(data: bytes) -> int:
    """The 32-bit BPHash used by CNetMgr::SendMsg/OnNetworkRead."""
    value = 0
    for byte in data:
        # libgame.so loads every character with ARM `ldrsb`, so bytes above
        # 0x7f are sign-extended before the XOR.  Treating them as unsigned
        # happens to work when four later ASCII bytes shift the difference
        # out, but rejects binary battle reports whose tail contains them.
        signed_byte = byte if byte < 0x80 else byte - 0x100
        value = (((value << 7) & 0xFFFFFFFF) ^ signed_byte) & 0xFFFFFFFF
    return value


def pack_transport_frame(application_packet: bytes) -> bytes:
    checksum = bp_hash(application_packet)
    size = len(application_packet) + 4
    return struct.pack(">II", PACKET_ID, size) + application_packet + struct.pack(">I", checksum)


def unpack_transport_frame(frame: bytes) -> bytes:
    if len(frame) < 12:
        raise ProtocolError("transport frame is too short")
    packet_id, size = struct.unpack_from(">II", frame)
    if packet_id != PACKET_ID:
        raise ProtocolError(f"unexpected packet id 0x{packet_id:08x}")
    if len(frame) != 8 + size or size < 4:
        raise ProtocolError(f"transport size mismatch: header={size}, actual={len(frame) - 8}")
    application = frame[8:-4]
    expected = struct.unpack_from(">I", frame, len(frame) - 4)[0]
    actual = bp_hash(application)
    if actual != expected:
        raise ProtocolError(f"BPHash mismatch: expected=0x{expected:08x}, actual=0x{actual:08x}")
    return application


@dataclass
class FrameBuffer:
    """Incrementally split a TCP byte stream into verified application packets."""

    data: bytearray

    def __init__(self) -> None:
        self.data = bytearray()

    def feed(self, chunk: bytes) -> list[bytes]:
        self.data.extend(chunk)
        packets: list[bytes] = []
        while len(self.data) >= 8:
            packet_id, size = struct.unpack_from(">II", self.data)
            if packet_id != PACKET_ID:
                raise ProtocolError(f"unexpected packet id 0x{packet_id:08x}")
            total = 8 + size
            if size < 4:
                raise ProtocolError(f"invalid transport size {size}")
            if len(self.data) < total:
                break
            frame = bytes(self.data[:total])
            del self.data[:total]
            packets.append(unpack_transport_frame(frame))
        return packets
