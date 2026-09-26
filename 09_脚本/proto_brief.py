#!/usr/bin/env python3
"""Print a compact brief of protocol modules for implementing handlers.

  python 09_脚本/proto_brief.py 61 17      # commands + wire fields of used types
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCHEMA = json.loads((ROOT / "05_改造/schema/protocol_schema.json").read_text(encoding="utf-8"))
CODES = json.loads((ROOT / "05_改造/schema/protocol_codes.json").read_text(encoding="utf-8"))
TYPES = SCHEMA["types_full"]


def label(t) -> str:
    if isinstance(t, str):
        return t.split(".")[-1]
    if isinstance(t, dict) and "__ref" in t:
        return t["__ref"]
    if isinstance(t, dict) and "__call" in t:
        args = t.get("args") or [t.get("arg")]
        return f'{t["__call"]}(' + ",".join(label(a) for a in args) + ")"
    if isinstance(t, dict):
        return "{" + ", ".join(f"{k}:{label(v)}" for k, v in t.items()) + "}"
    return str(t)


def refs(t, out: set) -> None:
    if isinstance(t, str) and t in TYPES:
        out.add(t)
    elif isinstance(t, dict):
        for v in t.values():
            refs(v, out)
    elif isinstance(t, list):
        for v in t:
            refs(v, out)


def describe(name: str) -> str:
    t = TYPES[name]
    if isinstance(t, dict) and t.get("__call") in ("enum", "const"):
        return f"  {label(name)} = {t['__call']} {json.dumps(t.get('arg'), ensure_ascii=False)}"
    wire = CODES["object"].get(name, {}).get("fields") or list(t)
    fields = ", ".join(f"{f}:{label(t.get(f, t.get('is' + f[:1].upper() + f[1:])))}" for f in wire)
    return f"  {label(name)} {{{fields}}}"


def main() -> None:
    wanted = {int(a) for a in sys.argv[1:]}
    for name, module in sorted(SCHEMA["modules"].items(), key=lambda kv: kv[1].get("mod") or -1):
        if module.get("mod") not in wanted:
            continue
        print(f"## {name} (mod {module['mod']})")
        used: set = set()
        for cmd_name, cmd in sorted(module["cmd"].items(), key=lambda kv: kv[1][0]):
            req = cmd[1] if len(cmd) > 1 else None
            resp = cmd[2] if len(cmd) > 2 else None
            print(f"  {cmd[0]:>3} {cmd_name}: {label(req)} -> {label(resp)}")
            refs(req, used)
            refs(resp, used)
        seen = set()
        while used - seen:
            for name2 in sorted(used - seen):
                seen.add(name2)
                if not name2.endswith(("CostResult", "RewardResult", "CostAndReward", "HeroVo")):
                    refs(TYPES[name2], used)
        for name2 in sorted(seen):
            if not name2.endswith(("CostResult", "RewardResult", "CostAndReward", "HeroVo", "RewardType", "CostType")):
                print(describe(name2))
        for key, value in TYPES.items():
            if key.endswith("Result") and ".facade." in key and key.split(".")[4] == name[3:].lower() and isinstance(value, dict):
                print(f"  codes {label(key)} {json.dumps(value.get('arg'), ensure_ascii=False)}")


if __name__ == "__main__":
    main()
