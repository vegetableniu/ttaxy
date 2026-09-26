"""Deterministic battle report generation for the original client renderer."""

from __future__ import annotations

import json
import math
from pathlib import Path
import struct
from typing import Any

from .defaults import long_id
from .protocol import ProtocolError
from .storage import AccountRecord


def decode_long_id(value: bytes) -> int:
    if not isinstance(value, (bytes, bytearray)) or len(value) < 2:
        raise ProtocolError("invalid encoded long id")
    negative = bool(value[0] & 0x08)
    tag = value[1]
    if tag < 0x80:
        number = tag
    else:
        size = tag & 0x07
        if size == 0 or len(value) != size + 2:
            raise ProtocolError("invalid encoded long id length")
        number = int.from_bytes(value[2:], "big")
    return -number if negative else number


# db.dat tables whose xlsconfig field lists are identical cannot be named by
# 30_extract_db.py; these were identified by content.
TABLE_ALIASES = {
    "ConfigValue": "_key_8f7cc034",            # HERO:BUY_PACK_COST, POINT:*, ...
    "DailyCheckConfig": "_key_0411dd75",       # day 7 = MYSTCARD
    "FirstDailyCheckConfig": "_key_963314ef",  # newbie week, day 7 = hero 5467
}


class GameConfig:
    def __init__(self, path: Path):
        raw = json.loads(path.read_text(encoding="utf-8"))
        for name, key in TABLE_ALIASES.items():
            if name not in raw and key in raw:
                raw[name] = raw[key]
        self.raw = raw
        self._indexes: dict[tuple[str, str], dict] = {}
        self.heroes = {int(row["id"]): row for row in raw["BaseHero"]}
        self.battles = {str(row["id"]): row for row in raw["BattleInfoConfig"]}
        self.levels = {int(row["id"]): row for row in raw["LevelConfig"]}

    def rows(self, table: str) -> list[dict[str, Any]]:
        return self.raw.get(table, [])

    def index(self, table: str, key: str = "id") -> dict[Any, dict[str, Any]]:
        cached = self._indexes.get((table, key))
        if cached is None:
            cached = {row[key]: row for row in self.rows(table) if key in row}
            self._indexes[(table, key)] = cached
        return cached

    def value(self, key: str, default: Any = None) -> Any:
        """A ConfigValue entry, JSON-decoded when possible (server settings)."""
        row = self.index("ConfigValue").get(key)
        if row is None:
            return default
        content = row.get("content")
        try:
            return json.loads(content)
        except (TypeError, ValueError):
            return content

    def hero(self, base_id: int) -> dict[str, Any]:
        try:
            return self.heroes[base_id]
        except KeyError as error:
            raise ProtocolError(f"unknown hero base id {base_id}") from error

    def battle(self, battle_id: str) -> dict[str, Any]:
        try:
            return self.battles[battle_id]
        except KeyError as error:
            raise ProtocolError(f"unknown battle id {battle_id}") from error


def _stats(config: GameConfig, base_id: int, level: int) -> tuple[int, int, int]:
    info = config.hero(base_id)
    initial = json.loads(info.get("initValues") or "{}")
    growth = json.loads(info.get("initGrows") or "{}")
    hp = math.floor(initial.get("LIFE", 100) + level * growth.get("LIFE", 10))
    attack = math.floor(initial.get("ATTACK", 10) + level * growth.get("ATTACK", 2))
    return hp, attack, int(info.get("normalSkill") or 101)


def _byte(value: int) -> bytes:
    return bytes((value & 0xFF,))


def _u16(value: int) -> bytes:
    return struct.pack(">H", value & 0xFFFF)


def _i32(value: int) -> bytes:
    return struct.pack(">i", value)


def _unit(slot: int, model: int, unit_class: int, hp: int) -> bytes:
    return (
        _byte(slot)
        + _u16(model)
        + _byte(0)
        + _byte(unit_class)
        + _i32(hp)
        + _i32(hp)
        + _byte(1)
    )


def _team(units: list[bytes]) -> bytes:
    return b"".join(units) + b"\xff\x00"


def _action(actor_slot: int, skill_id: int, target_slot: int, damage: int) -> bytes:
    # target, state, typed-value count/type/value, buff count, passive count;
    # then action-passive count. This is the 1.0.8.0 report layout.
    target = (
        _byte(target_slot)
        + _byte(0)
        + _byte(1)
        + _byte(1)
        + _i32(-damage)
        + _byte(0)
        + _byte(0)
    )
    return _byte(actor_slot) + _u16(skill_id) + _byte(1) + target + _byte(0)


def build_battle_report(
    config: GameConfig,
    account: AccountRecord,
    battle_id: str,
    embattle: list[list[bytes]],
    wave_index: int = 0,
) -> bytes:
    battle = config.battle(battle_id)
    slots = [
        (row_index * 2 + column_index, decode_long_id(hero_id))
        for row_index, row in enumerate(embattle)
        for column_index, hero_id in enumerate(row)
        if decode_long_id(hero_id) != 0
    ]
    if not slots:
        raise ProtocolError("battle formation is empty")
    if account.hero_id not in {hero_id for _, hero_id in slots}:
        raise ProtocolError("battle formation does not contain the saved starter hero")

    player_level = max(1, int(account.state["player"].get("level", 1)))
    attacker_hp, attacker_attack, attacker_skill = _stats(config, account.starter_hero, player_level)
    # The proprietary server's exact enemy roster is absent from the APK. The
    # eight low-level NPC models are shipped locally and cover the original
    # chapter-one visual set, so choose one deterministically per stage/wave.
    enemy_models = (11, 21, 31, 41, 51, 61, 71, 81)
    stage_index = max(0, int(battle.get("sort") or 1) - 1)
    enemy_base_id = enemy_models[(stage_index + wave_index) % len(enemy_models)]
    enemy_level = max(1, int(battle.get("level") or player_level))
    enemy_hp, enemy_attack, enemy_skill = _stats(config, enemy_base_id, enemy_level)

    report = _team([
        _unit(slot, account.starter_hero, 1, attacker_hp)
        for slot, _hero_id in slots
    ])
    report += _team([_unit(6, enemy_base_id, 3, enemy_hp)])
    attacker_damage = max(
        math.floor(attacker_attack * 1.15), math.ceil(enemy_hp / max(4, len(slots) * 6))
    )
    enemy_damage = min(
        max(1, math.floor(enemy_attack * 1.15)),
        max(1, math.floor((attacker_hp - 1) / 9)),
    )

    remaining_enemy = enemy_hp
    remaining_attackers = {slot: attacker_hp for slot, _hero_id in slots}
    while remaining_enemy > 0 and any(hp > 0 for hp in remaining_attackers.values()):
        actions = b""
        for slot, _hero_id in slots:
            if remaining_attackers[slot] <= 0 or remaining_enemy <= 0:
                continue
            damage = min(attacker_damage, remaining_enemy)
            remaining_enemy -= damage
            actions += _action(slot, attacker_skill, 6, damage)
        if remaining_enemy > 0:
            target = next(slot for slot, hp in remaining_attackers.items() if hp > 0)
            damage = min(enemy_damage, max(0, remaining_attackers[target] - 1))
            remaining_attackers[target] -= damage
            actions += _action(6, enemy_skill, target, damage)
        report += b"\xff" + actions + b"\xff\xff\x00\x00\xff"
    return report + _byte(1)


def battle_triggers(
    config: GameConfig,
    account: AccountRecord,
    battle_id: str,
    embattle: list[list[bytes]],
) -> list[dict[str, Any]]:
    battle = config.battle(battle_id)
    wave_count = max(1, int(battle.get("enemies") or 1))
    total_coins = 100 + max(1, int(battle.get("level") or 1)) * 50
    per_wave, remainder = divmod(total_coins, wave_count)
    return [
        {
            "coins": per_wave + (1 if index < remainder else 0),
            "drops": [],
            "finished": index == wave_count - 1,
            "index": index,
            "reports": build_battle_report(config, account, battle_id, embattle, index),
            "success": True,
        }
        for index in range(wave_count)
    ]


# Kept for callers/tests that refer to the first-guide helper by its old name.
def first_battle_trigger(config, account, battle_id, embattle):
    return battle_triggers(config, account, battle_id, embattle)[0]
