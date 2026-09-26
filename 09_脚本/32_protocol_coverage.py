#!/usr/bin/env python3
"""Generate an auditable protocol coverage inventory.

Finding a LocalServer handler only proves that an explicit prototype exists.
It never marks a command complete; completion requires real-device evidence.
"""

from __future__ import annotations

import csv
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCHEMA_PATH = ROOT / "05_改造" / "schema" / "protocol_schema.json"
HANDLER_PATH = ROOT / "05_改造" / "lua" / "LocalServer_logic.lua"
DOC_DIR = ROOT / "文档"
CSV_PATH = DOC_DIR / "协议覆盖自动生成.csv"
MD_PATH = DOC_DIR / "协议覆盖自动生成.md"

HANDLER_RE = re.compile(r'^\s*H\["(?P<mod>\d+):(?P<cmd>-?\d+)"\]\s*=\s*function\b')


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


def iter_commands(schema: dict, handlers: dict[tuple[int, int], int]):
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
            yield {
                "module": module_name,
                "mod": int(mod),
                "command": command_name,
                "cmd": cmd,
                "request": type_label(request),
                "response": type_label(response),
                "handler": f"LocalServer_logic.lua:{line}" if line else "",
                "coverage": "显式原型" if line else "默认应答/未实现",
                "test_case": "",
                "evidence": "",
            }


def write_csv(rows: list[dict[str, object]]) -> None:
    fields = [
        "module", "mod", "command", "cmd", "request", "response",
        "handler", "coverage", "test_case", "evidence",
    ]
    with CSV_PATH.open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def md_escape(value: object) -> str:
    return str(value).replace("|", "\\|").replace("\n", " ")


def write_markdown(rows: list[dict[str, object]]) -> None:
    explicit = sum(row["coverage"] == "显式原型" for row in rows)
    modules = len({row["mod"] for row in rows})
    lines = [
        "# 协议覆盖自动生成清单",
        "",
        "> 此文件由 `09_脚本/32_protocol_coverage.py` 生成，请勿手工编辑。",
        "> “显式原型”只表示存在内嵌 handler，不表示规则与原版一致，也不计为完成。",
        "",
        f"- 协议模块：{modules}",
        f"- 协议命令：{len(rows)}",
        f"- 显式原型：{explicit}",
        f"- 默认应答或未实现：{len(rows) - explicit}",
        "- 已有完整实现：0（完整状态必须人工审查并附实机证据）",
        "",
        "| 模块 | mod | 命令 | cmd | 请求 | 响应 | 当前覆盖 | handler |",
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
    rows = list(iter_commands(schema, handlers))
    DOC_DIR.mkdir(parents=True, exist_ok=True)
    write_csv(rows)
    write_markdown(rows)
    explicit = sum(row["coverage"] == "显式原型" for row in rows)
    print(f"modules={len({row['mod'] for row in rows})} commands={len(rows)} explicit={explicit}")
    print(MD_PATH)
    print(CSV_PATH)


if __name__ == "__main__":
    main()
