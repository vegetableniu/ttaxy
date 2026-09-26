#!/usr/bin/env python3
"""Generate an auditable protocol coverage inventory.

Coverage is measured against the standalone server (server/hakimi_server),
which is the final implementation.  Handlers in the legacy in-client
LocalServer_logic.lua are listed only as reverse-engineering references.
"""

from __future__ import annotations

import csv
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCHEMA_PATH = ROOT / "05_改造" / "schema" / "protocol_schema.json"
HANDLER_PATH = ROOT / "05_改造" / "lua" / "LocalServer_logic.lua"
SERVER_DIR = ROOT / "server" / "hakimi_server"
DOC_DIR = ROOT / "文档"
CSV_PATH = DOC_DIR / "协议覆盖自动生成.csv"
MD_PATH = DOC_DIR / "协议覆盖自动生成.md"

HANDLER_RE = re.compile(r'^\s*H\["(?P<mod>\d+):(?P<cmd>-?\d+)"\]\s*=\s*function\b')
# Matches both `(request.mod, request.cmd) == (10, 4)` and `@route(10, 4)`.
SERVER_RE = re.compile(r'(?:==\s*|route\()\(?\s*(?P<mod>\d+)\s*,\s*(?P<cmd>-?\d+)\s*\)')


def type_label(value: object) -> str:
    """Return a compact, deterministic label for a schema type expression."""
    if value is None:
        return "—"
    if isinstance(value, str):
        return value
    if isinstance(value, list):
        return "[" + ", ".join(type_label(item) for item in value) + "]"
    if not isinstance(value, dict):
        return str(value)
    if "__ref" in value:
        return str(value["__ref"])
    if "__call" in value:
        args = value.get("args")
        if not isinstance(args, list):
            args = [value.get("arg")]
        return f'{value["__call"]}(' + ", ".join(type_label(arg) for arg in args) + ")"
    if not value:
        return "{}"
    fields = ", ".join(f"{key}:{type_label(item)}" for key, item in value.items())
    return "{" + fields + "}"


def read_handlers() -> dict[tuple[int, int], int]:
    handlers: dict[tuple[int, int], int] = {}
    for line_number, line in enumerate(HANDLER_PATH.read_text(encoding="utf-8").splitlines(), 1):
        match = HANDLER_RE.match(line)
        if match:
            handlers[(int(match["mod"]), int(match["cmd"]))] = line_number
    return handlers


def read_server_handlers() -> dict[tuple[int, int], str]:
    handlers: dict[tuple[int, int], str] = {}
    for path in sorted(SERVER_DIR.glob("*.py")):
        for line_number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            for match in SERVER_RE.finditer(line):
                key = (int(match["mod"]), int(match["cmd"]))
                handlers.setdefault(key, f"{path.name}:{line_number}")
    return handlers


def iter_commands(schema: dict, handlers: dict[tuple[int, int], int],
                  server: dict[tuple[int, int], str]):
    for module_name, module in sorted(schema["modules"].items()):
        mod = module.get("mod")
        commands = module.get("cmd")
        if mod is None or not isinstance(commands, dict):
            continue
        for command_name, command in sorted(commands.items(), key=lambda item: item[1][0]):
            cmd = int(command[0])
            request = command[1] if len(command) > 1 else None
            response = command[2] if len(command) > 2 else None
            line = handlers.get((int(mod), cmd))
            served = server.get((int(mod), cmd), "")
            yield {
                "module": module_name,
                "mod": int(mod),
                "command": command_name,
                "cmd": cmd,
                "request": type_label(request),
                "response": type_label(response),
                "handler": served,
                "legacy": f"LocalServer_logic.lua:{line}" if line else "",
                "coverage": "服务端已实现" if served else ("仅旧原型参考" if line else "未实现"),
                "test_case": "",
                "evidence": "",
            }


def write_csv(rows: list[dict[str, object]]) -> None:
    fields = [
        "module", "mod", "command", "cmd", "request", "response",
        "handler", "legacy", "coverage", "test_case", "evidence",
    ]
    with CSV_PATH.open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def md_escape(value: object) -> str:
    return str(value).replace("|", "\\|").replace("\n", " ")


def write_markdown(rows: list[dict[str, object]]) -> None:
    done = sum(row["coverage"] == "服务端已实现" for row in rows)
    legacy = sum(row["coverage"] == "仅旧原型参考" for row in rows)
    modules = len({row["mod"] for row in rows})
    lines = [
        "# 协议覆盖自动生成清单",
        "",
        "> 此文件由 `09_脚本/32_protocol_coverage.py` 生成，请勿手工编辑。",
        "> “服务端已实现”= `server/hakimi_server` 有显式处理；“仅旧原型参考”= 只有旧的内嵌 `LocalServer_logic.lua` 实现，可作逆向参考。",
        "",
        f"- 协议模块：{modules}",
        f"- 协议命令：{len(rows)}",
        f"- 服务端已实现：{done}（{done * 100 // max(len(rows), 1)}%）",
        f"- 仅旧原型参考：{legacy}",
        f"- 未实现：{len(rows) - done - legacy}",
        "",
        "| 模块 | mod | 命令 | cmd | 请求 | 响应 | 当前覆盖 | 服务端位置 |",
        "|---|---:|---|---:|---|---|---|---|",
    ]
    for row in rows:
        lines.append(
            "| " + " | ".join(
                md_escape(row[key])
                for key in ("module", "mod", "command", "cmd", "request", "response", "coverage", "handler")
            ) + " |"
        )
    MD_PATH.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    handlers = read_handlers()
    rows = list(iter_commands(schema, handlers, read_server_handlers()))
    DOC_DIR.mkdir(parents=True, exist_ok=True)
    write_csv(rows)
    write_markdown(rows)
    done = sum(row["coverage"] == "服务端已实现" for row in rows)
    print(f"modules={len({row['mod'] for row in rows})} commands={len(rows)} server={done}")
    print(MD_PATH)
    print(CSV_PATH)


if __name__ == "__main__":
    main()
