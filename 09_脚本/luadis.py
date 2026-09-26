#!/usr/bin/env python3
"""Lua 5.1 bytecode disassembler for the stock script.dat modules.

The decompiled sources in 04_Lua源码 lose register/self semantics.  This
listing is exact: every instruction with constants and globals resolved.

Usage:
  python 09_脚本/luadis.py Logic/Reward              # module from script.dat
  python 09_脚本/luadis.py Logic/Reward AddOneReward # only matching functions
"""

from __future__ import annotations

import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT_DAT = ROOT / "01_解包" / "assets" / "script.dat"
MODULE_LIST = ROOT / "02_分析" / "module_list.txt"

OPS = ("MOVE LOADK LOADBOOL LOADNIL GETUPVAL GETGLOBAL GETTABLE SETGLOBAL "
       "SETUPVAL SETTABLE NEWTABLE SELF ADD SUB MUL DIV MOD POW UNM NOT LEN "
       "CONCAT JMP EQ LT LE TEST TESTSET CALL TAILCALL RETURN FORLOOP FORPREP "
       "TFORLOOP SETLIST CLOSE CLOSURE VARARG").split()


class Reader:
    def __init__(self, data: bytes):
        self.data, self.pos = data, 0
        header = data[:12]
        if header[:5] != b"\x1bLua\x51":
            raise ValueError("not Lua 5.1 bytecode")
        self.size_t = header[8]
        self.pos = 12

    def byte(self) -> int:
        self.pos += 1
        return self.data[self.pos - 1]

    def int(self) -> int:
        self.pos += 4
        return struct.unpack_from("<i", self.data, self.pos - 4)[0]

    def string(self):
        fmt = "<I" if self.size_t == 4 else "<Q"
        n = struct.unpack_from(fmt, self.data, self.pos)[0]
        self.pos += self.size_t
        if n == 0:
            return None
        s = self.data[self.pos:self.pos + n - 1]
        self.pos += n
        return s.decode("utf-8", "replace")

    def function(self, name="main"):
        self.string()
        self.int(); self.int()
        nups, nparams, vararg, stack = (self.byte() for _ in range(4))
        code = [struct.unpack_from("<I", self.data, self.pos + 4 * i)[0]
                for i in range(self.int())]
        self.pos += 4 * len(code)
        consts = []
        for _ in range(self.int()):
            t = self.byte()
            if t == 0:
                consts.append(None)
            elif t == 1:
                consts.append(bool(self.byte()))
            elif t == 3:
                consts.append(struct.unpack_from("<d", self.data, self.pos)[0]); self.pos += 8
            elif t == 4:
                consts.append(self.string())
            else:
                raise ValueError(f"bad constant type {t}")
        protos = [self.function() for _ in range(self.int())]
        n = self.int()                                   # lineinfo
        self.pos += 4 * n
        for _ in range(self.int()):                      # locvars
            self.string(); self.int(); self.int()
        ups = [self.string() for _ in range(self.int())]
        return {"name": name, "nparams": nparams, "code": code, "consts": consts,
                "protos": protos, "ups": ups, "nups": nups}


def fmt_const(value) -> str:
    if isinstance(value, str):
        return '"' + value.replace("\n", "\\n") + '"'
    if isinstance(value, float) and value.is_integer():
        return str(int(value))
    return repr(value)


def listing(fn, depth=0, out=None, names=None):
    out = [] if out is None else out
    K = fn["consts"]

    def rk(x):
        return fmt_const(K[x - 256]) if x >= 256 else f"R{x}"

    pad = "  " * depth
    out.append(f"{pad}function {fn['name']} (params={fn['nparams']}, upvals={fn['nups']})")
    pending_names = {}
    for pc, ins in enumerate(fn["code"]):
        op = OPS[ins & 0x3F]
        a, c, b = (ins >> 6) & 0xFF, (ins >> 14) & 0x1FF, (ins >> 23) & 0x1FF
        bx = ins >> 14
        sbx = bx - 131071
        if op == "MOVE": t = f"R{a} = R{b}"
        elif op == "LOADK": t = f"R{a} = {fmt_const(K[bx])}"
        elif op == "LOADBOOL": t = f"R{a} = {bool(b)}" + ("; skip" if c else "")
        elif op == "LOADNIL": t = f"R{a}..R{b} = nil"
        elif op == "GETUPVAL": t = f"R{a} = U{b}"
        elif op == "GETGLOBAL": t = f"R{a} = {K[bx]}"
        elif op == "GETTABLE": t = f"R{a} = R{b}[{rk(c)}]"
        elif op == "SETGLOBAL": t = f"{K[bx]} = R{a}"
        elif op == "SETUPVAL": t = f"U{b} = R{a}"
        elif op == "SETTABLE": t = f"R{a}[{rk(b)}] = {rk(c)}"
        elif op == "NEWTABLE": t = f"R{a} = {{}}"
        elif op == "SELF": t = f"R{a+1} = R{b}; R{a} = R{b}[{rk(c)}]"
        elif op in ("ADD", "SUB", "MUL", "DIV", "MOD", "POW"):
            sym = {"ADD": "+", "SUB": "-", "MUL": "*", "DIV": "/", "MOD": "%", "POW": "^"}[op]
            t = f"R{a} = {rk(b)} {sym} {rk(c)}"
        elif op == "UNM": t = f"R{a} = -R{b}"
        elif op == "NOT": t = f"R{a} = not R{b}"
        elif op == "LEN": t = f"R{a} = #R{b}"
        elif op == "CONCAT": t = f"R{a} = " + " .. ".join(f"R{i}" for i in range(b, c + 1))
        elif op == "JMP": t = f"goto {pc + 1 + sbx}"
        elif op in ("EQ", "LT", "LE"):
            sym = {"EQ": "==", "LT": "<", "LE": "<="}[op]
            t = f"if ({rk(b)} {sym} {rk(c)}) ~= {bool(a)} then skip"
        elif op == "TEST": t = f"if {'not ' if c else ''}R{a} then skip"
        elif op == "TESTSET": t = f"if R{b} <=> {c} then R{a} = R{b} else skip"
        elif op in ("CALL", "TAILCALL"):
            args = "..." if b == 0 else ", ".join(f"R{i}" for i in range(a + 1, a + b))
            rets = "" if c == 1 else ("R{}.. = ".format(a) if c == 0 else
                                      ", ".join(f"R{i}" for i in range(a, a + c - 1)) + " = ")
            t = f"{rets}R{a}({args})" + (" [tail]" if op == "TAILCALL" else "")
        elif op == "RETURN":
            t = "return " + ("..." if b == 0 else ", ".join(f"R{i}" for i in range(a, a + b - 1)))
        elif op == "FORLOOP": t = f"R{a} += R{a+2}; if R{a} <?= R{a+1} goto {pc + 1 + sbx}"
        elif op == "FORPREP": t = f"R{a} -= R{a+2}; goto {pc + 1 + sbx}"
        elif op == "TFORLOOP": t = f"R{a+3}.. = R{a}(R{a+1}, R{a+2}); if R{a+3} ~= nil then R{a+2} = R{a+3} else skip"
        elif op == "SETLIST": t = f"R{a}[...] = R{a+1}..R{a+b}"
        elif op == "CLOSE": t = f"close >= R{a}"
        elif op == "CLOSURE":
            t = f"R{a} = closure#{bx}"
            pending_names[bx] = pc
        elif op == "VARARG": t = f"R{a}.. = ..."
        else: t = op
        out.append(f"{pad}  [{pc:4d}] {op:<9} {t}")
    for i, proto in enumerate(fn["protos"]):
        # name the closure by the table key / global it is stored under
        proto["name"] = f"closure#{i}"
        pc = pending_names.get(i)
        if pc is not None:
            skip = proto["nups"]  # CLOSURE is followed by one pseudo-op per upvalue
            for nxt in fn["code"][pc + 1 + skip:pc + 3 + skip]:
                nop = OPS[nxt & 0x3F]
                if nop == "SETTABLE":
                    key = (nxt >> 23) & 0x1FF
                    if key >= 256:
                        proto["name"] = str(K[key - 256]); break
                    # >256 constants: key was loaded by LOADK just before CLOSURE
                    prev = fn["code"][pc - 1] if pc else 0
                    if OPS[prev & 0x3F] == "LOADK" and (prev >> 6) & 0xFF == key:
                        proto["name"] = str(K[prev >> 14]); break
                if nop == "SETGLOBAL":
                    proto["name"] = str(K[nxt >> 14]); break
        listing(proto, depth + 1, out)
    return out


def load_module(name: str) -> bytes:
    key = None
    for line in MODULE_LIST.read_text(encoding="utf-8").splitlines():
        parts = line.split()
        if len(parts) >= 2 and parts[1] == name:
            key = int(parts[0], 16)
    if key is None:
        raise SystemExit(f"module not found: {name}")
    data = SCRIPT_DAT.read_bytes()
    count, end = struct.unpack_from("<II", data, 4)
    for i in range(count):
        k, offset, size, _ = struct.unpack_from("<IIII", data, end + i * 16)
        if k == key:
            return data[offset:offset + size]
    raise SystemExit(f"key {key:08x} not in script.dat")


def main() -> None:
    target = sys.argv[1]
    data = Path(target).read_bytes() if Path(target).is_file() else load_module(target)
    lines = listing(Reader(data).function())
    if len(sys.argv) > 2:
        wanted, keep, depth = sys.argv[2], False, None
        for line in lines:
            stripped = line.lstrip()
            if stripped.startswith("function "):
                indent = len(line) - len(stripped)
                if keep and indent <= depth:
                    keep = False
                if not keep and wanted in stripped.split()[1]:
                    keep, depth = True, indent
            if keep:
                print(line)
    else:
        print("\n".join(lines))


if __name__ == "__main__":
    main()
