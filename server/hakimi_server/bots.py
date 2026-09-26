"""Deterministic local "players" standing in for the retired online world.

A bot is fully derived from its id, so it never needs storing: name from
RandName (adjective + noun), level near a requested level, and a formation of
hero cards whose star grade follows the level.  Used by friends, arena, PVP,
rankings and chat.
"""

from __future__ import annotations

import random
from dataclasses import dataclass

from .defaults import long_id

BOT_BASE = 90_000_000


@dataclass
class Bot:
    id: int
    name: str
    level: int
    cards: list[tuple[int, int, int]]  # (slot, baseId, level)

    @property
    def leader(self) -> int:
        return self.cards[0][1]

    def power(self, config) -> int:
        import json
        total = 0
        for _, base, level in self.cards:
            info = config.heroes.get(base, {})
            init = json.loads(info.get("initValues") or "{}")
            grow = json.loads(info.get("initGrows") or "{}")
            total += int(init.get("ATTACK", 0) + level * grow.get("ATTACK", 0)
                         + (init.get("LIFE", 0) + level * grow.get("LIFE", 0)) / 10)
        return total


def _names(config) -> tuple[list[str], list[str]]:
    rows = config.rows("RandName")
    first = [r["value"] for r in rows if int(r["type"]) == 1] or ["无名"]
    second = [r["value"] for r in rows if int(r["type"]) != 1] or ["侠客"]
    return first, second


def _star_for(level: int) -> int:
    if level < 20:
        return 1
    if level < 45:
        return 3
    if level < 65:
        return 4
    return 7


def bot(config, bot_id: int, level_hint: int | None = None) -> Bot:
    rng = random.Random(bot_id)
    first, second = _names(config)
    name = rng.choice(first) + rng.choice(second)
    level = level_hint if level_hint is not None else rng.randint(5, 90)
    level = max(1, min(130, level))
    star = _star_for(level)
    heroes = [h for h in config.rows("BaseHero") if h["card"] == "HERO"
              and int(h["star"]) == star and ("仙玉寻仙" in h["gain"] or "关卡掉落" in h["gain"])]
    heroes = heroes or [h for h in config.rows("BaseHero") if h["card"] == "HERO" and int(h["star"]) == 1]
    count = 3 if level < 30 else 4 if level < 60 else 5
    slots = [1, 2, 5, 0, 3, 4][:count]
    picks = rng.sample(heroes, min(count, len(heroes)))
    cards = [(slot, int(h["id"]), level) for slot, h in zip(slots, picks)]
    return Bot(bot_id, name, level, cards)


def bots_near(config, level: int, count: int, seed: str) -> list[Bot]:
    rng = random.Random(seed)
    return [bot(config, BOT_BASE + rng.randrange(1, 9_000_000),
                max(1, level + rng.randint(-3, 3))) for _ in range(count)]


def is_bot(player_id: int) -> bool:
    return player_id >= BOT_BASE


def commend_vo(config, b: Bot, friend: bool = False) -> dict:
    return {"artifactLevel": 0, "baseId": b.leader, "cultivateVo": None, "equips": [],
            "friend": friend, "heroLevel": b.level, "id": long_id(b.id), "level": b.level,
            "name": b.name, "powerSkill": 0, "pvpDesId": 0, "talisman": [], "used": False,
            "userBuffs": []}


def friend_vo(config, b: Bot, now_ms: int) -> dict:
    return {"artifactLevel": 0, "baseId": b.leader, "cultivateVo": None, "equips": [],
            "heroLevel": b.level, "id": long_id(b.id), "level": b.level, "loginOn": now_ms,
            "name": b.name, "online": True, "powerSkill": 0, "pvpDesId": 0,
            "score": b.power(config), "talisman": [], "userBuffs": [], "vip": False}
