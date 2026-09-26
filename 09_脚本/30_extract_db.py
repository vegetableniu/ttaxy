#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
30_extract_db.py（哈基米西游版）——解析 assets/db.dat 配置数据库并 dump 全部表。
复用原版逆向出的 COPYRIGHT@SQL1 格式；表名->key 靠 xlsconfig.lua 的字段名序列匹配。
输出: 05_改造/data/config_dump.json
"""
import struct, re, os, json

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
DB = os.path.join(ROOT, '01_解包', 'assets', 'db.dat')
XLSCONFIG = os.path.join(ROOT, '04_Lua源码', 'src', 'xlsconfig.lua')
OUT_JSON = os.path.join(ROOT, '05_改造', 'data', 'config_dump.json')

MAGIC = b'COPYRIGHT@SQL1\x00\x00\x02\x2c\x33\x01'
SIZES = {1: 1, 4: 4, 5: 4, 7: 8, 10: 4}


def parse_pfdw(blob):
    assert blob[:4] == b'PFDW', 'bad PFDW magic'
    count, pend = struct.unpack_from('<II', blob, 4)
    return [struct.unpack_from('<IIII', blob, pend + i * 16) for i in range(count)]


def parse_sql_table(blob, off, size):
    if blob[off:off + 20] != MAGIC:
        return None
    b = blob
    colCount, rowCount, poolSize = struct.unpack_from('<III', b, off + 20)
    pool_off = off + size - poolSize
    p = off + 32
    cols = []
    for _ in range(colCount):
        t = b[p]
        name_off = struct.unpack_from('<I', b, p + 1)[0]
        p += 5
        cols.append((t, name_off))
    names = []
    for t, name_off in cols:
        e = b.find(b'\x00', pool_off + name_off, pool_off + poolSize)
        names.append(b[pool_off + name_off:e].decode('utf-8', 'replace'))

    def read_str(off2):
        if off2 >= poolSize:
            return ''
        e = b.find(b'\x00', pool_off + off2, pool_off + poolSize)
        return b[pool_off + off2:e].decode('utf-8', 'replace')

    rows = []
    for _ in range(rowCount):
        rec = {}
        for i, (t, _no) in enumerate(cols):
            sz = SIZES[t]
            raw = b[p:p + sz]
            p += sz
            nm = names[i]
            if t == 1:
                rec[nm] = raw[0]
            elif t == 4:
                rec[nm] = struct.unpack('<i', raw)[0]
            elif t == 5:
                rec[nm] = struct.unpack('<I', raw)[0]
            elif t == 7:
                rec[nm] = struct.unpack('<d', raw)[0]
            elif t == 10:
                rec[nm] = read_str(struct.unpack('<I', raw)[0])
        rows.append(rec)
    return names, rows


def parse_xlsconfig(path):
    txt = open(path, encoding='utf-8', errors='replace').read()
    tables = {}
    for blk in re.split(r'\bDEF\(', txt)[1:]:
        m = re.search(r'type\s*=\s*"([^"]+)"', blk)
        if not m:
            continue
        name = m.group(1)
        fields = re.findall(r'(?:index|field)\s*=\s*"([^"]+)"', blk)
        tables[name] = fields
    return tables


def main():
    blob = open(DB, 'rb').read()
    toc = parse_pfdw(blob)
    xls = parse_xlsconfig(XLSCONFIG)
    print('xlsconfig 表数量:', len(xls))

    sql_cols = {}
    for k, off, size, _r4 in toc:
        r = parse_sql_table(blob, off, size)
        if r:
            sql_cols[k] = (r[0], r[1], off, size)

    by_fields = {}
    for k, (names, rows, off, size) in sql_cols.items():
        by_fields.setdefault(tuple(names), []).append(k)

    name_to_key = {}
    unmatched = []
    for name, fields in xls.items():
        ks = by_fields.get(tuple(fields))
        if ks and len(ks) == 1:
            name_to_key[name] = ks[0]
        else:
            unmatched.append(name)

    print('匹配到表名 -> key：%d / %d' % (len(name_to_key), len(xls)))
    if unmatched:
        print('未匹配:', unmatched)

    os.makedirs(os.path.dirname(OUT_JSON), exist_ok=True)
    dump = {}
    for name in sorted(xls.keys()):
        k = name_to_key.get(name)
        if k is None:
            continue
        _n, rows, _o, _s = sql_cols[k]
        dump[name] = rows
    named_keys = set(name_to_key.values())
    for k, (names, rows, off, size) in sql_cols.items():
        if k not in named_keys:
            dump['_key_%08x' % k] = rows

    json.dump(dump, open(OUT_JSON, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    print('已写出 config_dump.json，共 %d 张表' % len(dump))

    # 关键表摘要
    for name in ('BaseHero', 'CampaignConfig', 'BattleInfoConfig', 'SkillConfig', 'HeroLevelConfig', 'ComposeConfig', 'RouletteLotteryConfig', 'LevelConfig'):
        k = name_to_key.get(name)
        if k is None:
            print('  [缺]', name)
            continue
        _n, rows, _o, _s = sql_cols[k]
        print('  %-20s key=%08x rows=%d fields=%s' % (name, k, len(rows), ','.join(_n)))


if __name__ == '__main__':
    main()
