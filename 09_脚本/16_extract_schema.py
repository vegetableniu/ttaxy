#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
从反编译后的 Net/Msg*.lua 里提取完整协议 schema（mod / cmd / types）-> JSON
输出: 05_改造/schema/protocol_schema.json
（哈基米西游版本：模块命名 Net__Msg*.lua，无 script__ 前缀）
"""
import os, re, json, sys

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
SRC = os.path.join(ROOT, '04_Lua源码', 'src')
OUT = os.path.join(ROOT, '05_改造', 'schema')
os.makedirs(OUT, exist_ok=True)


class P:
    def __init__(self, s):
        self.s = s
        self.i = 0

    def ws(self):
        while self.i < len(self.s) and self.s[self.i] in ' \t\r\n':
            self.i += 1

    def peek(self):
        self.ws()
        return self.s[self.i] if self.i < len(self.s) else ''

    def eat(self, c):
        self.ws()
        if self.s.startswith(c, self.i):
            self.i += len(c)
            return True
        return False

    def ident(self):
        self.ws()
        m = re.match(r'[A-Za-z_][A-Za-z0-9_.]*', self.s[self.i:])
        if not m:
            return None
        self.i += m.end()
        return m.group(0)

    def string(self):
        self.ws()
        q = self.s[self.i]
        if q not in '"\'':
            return None
        self.i += 1
        buf = []
        while self.i < len(self.s):
            c = self.s[self.i]
            if c == '\\':
                buf.append(self.s[self.i:self.i + 2])
                self.i += 2
                continue
            if c == q:
                self.i += 1
                break
            buf.append(c)
            self.i += 1
        return ''.join(buf)

    def number(self):
        self.ws()
        m = re.match(r'-?\d+(\.\d+)?', self.s[self.i:])
        if not m:
            return None
        self.i += m.end()
        return float(m.group(0)) if '.' in m.group(0) else int(m.group(0))

    def value(self):
        self.ws()
        c = self.peek()
        if c == '{':
            return self.table()
        if c in '"\'':
            return self.string()
        nm = self.ident()
        if nm in ('array', 'map', 'enum', 'const', 'set'):
            if not self.eat('('):
                return {'__call': nm}
            args = []
            if not self.eat(')'):
                while True:
                    args.append(self.value())
                    if self.eat(')'):
                        break
                    if not self.eat(','):
                        raise ValueError('Malformed type call at %d' % self.i)
            return {'__call': nm, 'arg': args[-1] if args else None, 'args': args}
        if nm is not None:
            if nm in ('true', 'false'):
                return nm == 'true'
            if nm == 'nil':
                return None
            return {'__ref': nm}
        n = self.number()
        if n is not None:
            return n
        return None

    def table(self):
        assert self.eat('{')
        obj = {}
        arr = []
        while True:
            self.ws()
            if self.eat('}'):
                break
            if self.i >= len(self.s):
                break
            start = self.i
            self.ws()
            if self.s.startswith('[', self.i):
                self.i += 1
                key = self.value()
                self.eat(']')
                self.eat('=')
                val = self.value()
                obj[str(key)] = val
            else:
                save = self.i
                nm = self.ident()
                self.ws()
                if nm is not None and self.s.startswith('=', self.i):
                    self.i += 1
                    obj[nm] = self.value()
                else:
                    self.i = save
                    arr.append(self.value())
            self.ws()
            if self.eat(','):
                pass
            elif self.eat('}'):
                break
            if self.i == start:
                break
        if arr and not obj:
            return arr
        if arr:
            obj['__array'] = arr
        return obj


def extract(path):
    txt = open(path, encoding='utf-8', errors='replace').read()
    out = {}
    m = re.search(r'^mod\s*=\s*(\d+)', txt, re.M)
    out['mod'] = int(m.group(1)) if m else None
    m = re.search(r'^cmd\s*=\s*', txt, re.M)
    if m:
        p = P(txt)
        p.i = m.end()
        out['cmd'] = p.value()
    m = re.search(r'^types\s*=\s*', txt, re.M)
    if m:
        p = P(txt)
        p.i = m.end()
        out['types'] = p.value()
    return out


def main():
    # ``types`` is kept for the in-client prototype, which historically uses
    # short names.  ``types_full`` preserves the real protocol identity and is
    # the authoritative source for the standalone server.  Merging only short
    # names can silently overwrite same-named models from different modules.
    merged = {'modules': {}, 'types': {}, 'types_full': {}}
    files = sorted(f for f in os.listdir(SRC) if f.startswith('Net__Msg') and f.endswith('.lua'))
    for f in files:
        name = f.replace('Net__', '').replace('.lua', '')
        try:
            d = extract(os.path.join(SRC, f))
        except Exception as e:
            print('FAIL', name, repr(e)[:120])
            continue
        domain = name[3:4].lower() + name[4:] if name.startswith('Msg') else name
        merged['modules'][name] = {
            'mod': d.get('mod'),
            'cmd': d.get('cmd'),
            'domain': domain,
        }
        for k, v in (d.get('types') or {}).items():
            merged['types'][k] = v
            merged['types_full']['com.eyu.mt.module.%s.%s' % (domain, k)] = v
        print('%-22s mod=%-5s cmds=%-4s types=%d' % (
            name, d.get('mod'), len(d.get('cmd') or {}), len(d.get('types') or {})))

    json.dump(merged, open(os.path.join(OUT, 'protocol_schema.json'), 'w', encoding='utf-8'),
              ensure_ascii=False, indent=1)
    print('\nmodules=%d types=%d full_types=%d -> %s' % (len(merged['modules']), len(merged['types']),
                                           len(merged['types_full']),
                                           os.path.join(OUT, 'protocol_schema.json')))


main()
