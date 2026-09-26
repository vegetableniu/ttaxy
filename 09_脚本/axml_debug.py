"""Add debuggable to a development APK without changing its resources."""
import struct


def enable_debug(blob, parser):
    strings, pool_size, _ = parser.parse_string_pool(blob, 8)
    name_index = len(strings)
    strings.append('debuggable')
    offsets, payload = [], bytearray()
    for value in strings:
        offsets.append(len(payload))
        encoded = value.encode('utf-16le')
        payload += struct.pack('<H', len(encoded) // 2) + encoded + b'\0\0'
    payload += b'\0' * (-len(payload) % 4)
    start = 28 + len(strings) * 4
    pool = struct.pack('<HH6I', 1, 28, start + len(payload), len(strings), 0, 0, start, 0)
    pool += struct.pack('<%dI' % len(offsets), *offsets) + payload
    chunks = []
    pos = 8 + pool_size
    while pos < len(blob):
        kind, header, size = struct.unpack_from('<HHI', blob, pos)
        chunk = bytearray(blob[pos:pos + size])
        if kind == 0x180:
            ids = list(struct.unpack_from('<%dI' % ((size - 8) // 4), chunk, 8))
            ids += [0] * (name_index - len(ids)) + [0x0101000f]
            chunk = struct.pack('<HHI', kind, header, 8 + 4 * len(ids)) + struct.pack('<%dI' % len(ids), *ids)
        elif kind == 0x102 and strings[struct.unpack_from('<I', chunk, 20)[0]] == 'application':
            attrstart, attrsize, count = struct.unpack_from('<HHH', chunk, 24)
            ns = strings.index('http://schemas.android.com/apk/res/android')
            attr = struct.pack('<IIIHBBI', ns, name_index, 0xffffffff, 8, 0, 0x12, 0xffffffff)
            end = 16 + attrstart + count * attrsize
            chunk[end:end] = attr
            struct.pack_into('<I', chunk, 4, len(chunk))
            struct.pack_into('<H', chunk, 28, count + 1)
        chunks.append(chunk)
        pos += size
    body = pool + b''.join(chunks)
    return struct.pack('<HHI', 3, 8, 8 + len(body)) + body
