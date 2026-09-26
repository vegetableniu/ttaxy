"""Editable server settings: server/config/server_settings.json.

Every value the original server kept private (prices, drop rates, lottery
pools, enemy strength, reward formulas) is read from that file, so it can be
tuned without touching code.  Usage: ``setting("battle.drop_rate", 0.3)``.
"""

from __future__ import annotations

import json
from pathlib import Path

PATH = Path(__file__).resolve().parents[1] / "config" / "server_settings.json"
_cache: dict | None = None


def load() -> dict:
    global _cache
    if _cache is None:
        _cache = json.loads(PATH.read_text(encoding="utf-8")) if PATH.exists() else {}
    return _cache


def setting(path: str, default=None):
    node = load()
    for part in path.split("."):
        if not isinstance(node, dict) or part not in node:
            return default
        node = node[part]
    return node
