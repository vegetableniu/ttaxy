# -*- coding: utf-8 -*-
"""解包 + 反编译哈基米西游 910 个 Lua 模块 -> 04_Lua源码/src"""
import os, struct, subprocess, time, zipfile

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
TT = r'C:\Users\nkq\Desktop\game\ttaxy'
JAVA = os.path.join(TT, '03_工具链', 'jdk', 'bin', 'java.exe')
UNLUAC = os.path.join(TT, '03_工具链', 'tools', 'unluac.jar')
OUT = os.path.join(ROOT, '04_Lua源码', 'src')
EXTRACT = os.path.join(ROOT, '02_分析', 'pack', 'extract', 'script')
os.makedirs(OUT, exist_ok=True)
os.makedirs(EXTRACT, exist_ok=True)

blob = open(os.path.join(ROOT, '01_解包', 'assets', 'script.dat'), 'rb').read()
cnt, pend = struct.unpack_from('<II', blob, 4)
toc = [struct.unpack_from('<IIII', blob, pend + i*16) for i in range(cnt)]


def modname(b):
    try:
        n = int.from_bytes(b[12:16], 'little')
        s = b[16:16+n-1].decode('utf-8', 'replace')
        m = s.split('assets\\')[-1].replace('\\', '/').lstrip('@')
        if m.startswith('script/'):
            m = m[len('script/'):]
        if m.endswith('.dat'):
            m = m[:-4]
        return m
    except Exception:
        return None


ok = fail = 0
t0 = time.time()
rows = []
for i, (k, off, size, r4) in enumerate(toc):
    b = blob[off:off+size]
    p = os.path.join(EXTRACT, '%04d_%08x.bin' % (i, k))
    open(p, 'wb').write(b)
    name = modname(b) or ('unknown/%04d_%08x' % (i, k))
    dest = os.path.join(OUT, name.replace('/', '__') + '.lua')
    if os.path.exists(dest) and os.path.getsize(dest) > 0:
        ok += 1
        continue
    try:
        r = subprocess.run([JAVA, '-jar', UNLUAC, p], capture_output=True, timeout=120)
        if r.returncode == 0 and r.stdout:
            open(dest, 'wb').write(r.stdout)
            ok += 1
        else:
            fail += 1
            if fail <= 8:
                print('FAIL', name, (r.stderr or b'')[-200:])
    except Exception as ex:
        fail += 1
        if fail <= 8:
            print('ERR', name, repr(ex)[:150])

with open(os.path.join(ROOT, '04_Lua源码', 'DECOMPILE_INDEX.txt'), 'w', encoding='utf-8') as f:
    for n, o, sz in rows:
        f.write('%s\t%s\t%d\n' % ('OK' if o else 'FAIL', n, sz))

print('decompiled OK=%d FAIL=%d in %.0fs' % (ok, fail, time.time() - t0))
print('output:', OUT)
