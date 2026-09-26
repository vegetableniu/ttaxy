"""Minimal binary Android XML (AXML) + ARSC string-pool parser.
Handles the standard AXML layout plus the non-standard 2-byte-length UTF-16
string pool variant found in some protected/repacked manifests.
"""
import struct, sys, re

RES_NULL=0x0000;RES_STRING=0x0003;RES_REFERENCE=0x0001;RES_ATTRIBUTE=0x0002
RES_FLOAT=0x0004;RES_DIMENSION=0x0005;RES_INT_DEC=0x0010;RES_INT_HEX=0x0011
RES_INT_BOOLEAN=0x0012;RES_INT_COLOR_ARGB8=0x001c;RES_INT_COLOR_RGB8=0x001d
RES_INT_COLOR_ARGB4=0x001e;RES_INT_COLOR_RGB4=0x001f

def _slen(data, off):
    n = data[off]
    if n & 0x80:
        n = ((n & 0x7f) << 8) | data[off+1]
        off += 2
        return ((n << 16) | (data[off] << 8) | data[off+1], off+2)
    return n, off+1

def _score(ss):
    if not ss:
        return 0.0
    good = 0; bad = 0
    for s in ss:
        for c in s:
            o = ord(c)
            if 0x20 <= o < 0x7f or 0x4e00 <= o <= 0x9fff or o in (0x0a, 0x0d, 0x09):
                good += 1
            elif o == 0:
                bad += 1
            elif (o & 0xff) == 0 or (o & 0xff00) == 0:
                bad += 2
            else:
                bad += 1
    return good / float(good + bad + 1)

def _decode(data, base, cnt, strstart, mode):
    offs = struct.unpack_from('<%dI' % cnt, data, base + struct.unpack_from('<H', data, base+2)[0])
    out = []
    ok = 0
    for o in offs:
        p = base + strstart + o
        try:
            if mode == 'utf8':
                n_u16, p2 = _slen(data, p)
                n_u8, p3 = _slen(data, p2)
                if n_u8 > 20000:
                    raise ValueError
                raw = data[p3:p3+n_u8]
                out.append(raw.decode('utf-8', 'replace'))
                if data[p3+n_u8] == 0:
                    ok += 1
            elif mode == 'u16_1':
                n, p2 = _slen(data, p)
                if n > 20000:
                    raise ValueError
                out.append(data[p2:p2+n*2].decode('utf-16-le', 'replace'))
                if data[p2+n*2] == 0 and data[p2+n*2+1] == 0:
                    ok += 1
            else:  # u16_2 : 2-byte little-endian length prefix
                n = struct.unpack_from('<H', data, p)[0]
                if n > 20000:
                    raise ValueError
                out.append(data[p+2:p+2+n*2].decode('utf-16-le', 'replace'))
                if data[p+2+n*2] == 0 and data[p+2+n*2+1] == 0:
                    ok += 1
        except Exception:
            out.append('')
    return out, ok

def parse_string_pool(data, base):
    typ, hsize, size = struct.unpack_from('<HHI', data, base)
    cnt, styc, flags, strstart, stystart = struct.unpack_from('<IIIII', data, base+8)
    utf8 = bool(flags & (1 << 8))
    modes = ['utf8', 'u16_1', 'u16_2']
    best = None
    for m in modes:
        try:
            ss, ok = _decode(data, base, cnt, strstart, m)
        except Exception:
            continue
        # terminators are the decisive structural signal; utf8 flag breaks ties
        sc = ok / float(cnt if cnt else 1)
        if m == 'utf8' and utf8:
            sc += 0.25
        if best is None or sc > best[0]:
            best = (sc, m, ss)
    return best[2], size, (best[1] == 'utf8')

def parse_axml(data):
    if struct.unpack_from('<H', data, 0)[0] != 0x0003:
        raise ValueError('not AXML')
    sp, pool_size, _ = parse_string_pool(data, 8)
    pos = 8 + pool_size
    res = []
    depth = 0
    while pos < len(data) - 8:
        typ, hsize, size = struct.unpack_from('<HHI', data, pos)
        if size == 0:
            break
        if typ == 0x0102:  # START_ELEMENT
            ns, name = struct.unpack_from('<iI', data, pos+16)
            attrstart, attrsize, attrcount = struct.unpack_from('<HHH', data, pos+24)
            attrs = []
            for i in range(attrcount):
                p = pos+16+attrstart+i*attrsize
                if p+20 > len(data):
                    break
                an = struct.unpack_from('<i', data, p+4)[0]
                vsz, vres0, vtype, vdata = struct.unpack_from('<HBBI', data, p+12)
                name_s = sp[an] if 0 <= an < len(sp) else '?'
                if vtype == RES_STRING and 0 <= vdata < len(sp):
                    val = sp[vdata]
                elif vtype == RES_REFERENCE:
                    val = '@0x%08x' % vdata
                elif vtype == RES_INT_BOOLEAN:
                    val = 'true' if vdata else 'false'
                elif vtype == RES_INT_DEC:
                    val = str(vdata)
                elif vtype == RES_INT_HEX:
                    val = hex(vdata)
                elif vtype in (RES_INT_COLOR_ARGB8, RES_INT_COLOR_RGB8, RES_INT_COLOR_ARGB4, RES_INT_COLOR_RGB4):
                    val = '#%08x' % vdata
                else:
                    val = '(%d)0x%x' % (vtype, vdata)
                attrs.append((name_s, val, vtype, vdata))
            res.append((depth, sp[name] if 0 <= name < len(sp) else '?', attrs))
            depth += 1
        elif typ == 0x0103:
            depth -= 1
        pos += size
    return res, sp

def to_xml(d):
    els, sp = parse_axml(d)
    out = ['<!-- string pool: %d entries -->' % len(sp),
           '<?xml version="1.0" encoding="utf-8"?>', '<AXML>']
    for depth, name, attrs in els:
        pad = '  '*(depth+1)
        a = ' '.join('%s="%s"' % (k, str(v).replace('&', '&amp;').replace('<', '&lt;').replace('"', '&quot;'))
                     for k, v, t, vd in attrs)
        out.append('%s<%s %s>' % (pad, name, a))
    out.append('</AXML>')
    return '\n'.join(out), sp

if __name__ == '__main__':
    d = open(sys.argv[1], 'rb').read()
    txt, sp = to_xml(d)
    dest = sys.argv[2] if len(sys.argv) > 2 else 'manifest.xml'
    open(dest, 'w', encoding='utf-8').write(txt)
    with open(dest + '.strings.txt', 'w', encoding='utf-8') as f:
        for i, s in enumerate(sp):
            f.write('%4d  %s\n' % (i, s))
    print('wrote', dest, len(txt), 'chars;', len(sp), 'pool strings')
