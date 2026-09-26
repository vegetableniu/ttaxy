"""New-player gift list and claims used by the stock guide flow."""

from __future__ import annotations

import json
from typing import Any

from .defaults import default_object, long_id
from .protocol import Schema
from .storage import AccountRecord


GUIDE_GIFTS = (
    {"slot": 1, "base_id": 311, "name": "新手升级材料"},
    {"slot": 2, "base_id": 103, "name": "新手进化材料"},
)


def gift_id(record: AccountRecord, slot: int) -> int:
    return record.player_id * 100 + slot


def hero_vo(schema: Schema, card: dict[str, Any]) -> dict[str, Any]:
    value = default_object(schema, "com.eyu.mt.module.hero.model.HeroVo")
    value.update(
        id=long_id(int(card["id"])),
        baseId=int(card["base_id"]),
        exp=int(card.get("exp", 0)),
        level=int(card.get("level", 1)),
        locked=bool(card.get("locked", False)),
        powerSkill=int(card.get("power_skill", 0)),
        skillExp=int(card.get("skill_exp", 0)),
    )
    return value


def grant_hero(
    schema: Schema, record: AccountRecord, state: dict[str, Any], base_id: int
) -> dict[str, Any]:
    cards = state.setdefault("heroes", [])
    highest = max(
        [record.hero_id, *(int(card["id"]) for card in cards)],
        default=record.hero_id,
    )
    card = {
        "id": highest + 1,
        "base_id": base_id,
        "level": 1,
        "exp": 0,
        "locked": False,
        "power_skill": 0,
        "skill_exp": 0,
    }
    cards.append(card)
    return {
        "additionRate": {},
        "amount": 1,
        "code": base_id,
        "contents": hero_vo(schema, card),
        "mail": False,
        "type": 5,
    }


def build_gift_list(schema: Schema, record: AccountRecord) -> dict[str, Any]:
    result = default_object(schema, "com.eyu.mt.module.gift.model.ValidGiftVo")
    state = record.state
    claimed = {int(value) for value in state.get("claimed_gifts", [])}
    users = []
    if "CN01BN01" in state.get("battles", []):
        for definition in GUIDE_GIFTS:
            identifier = gift_id(record, int(definition["slot"]))
            if identifier in claimed:
                continue
            gift = default_object(schema, "com.eyu.mt.module.gift.model.UserGiftVo")
            gift["id"] = long_id(identifier)
            gift["description"].update(
                info="",
                name=str(definition["name"]),
                showId=str(definition["base_id"]),
                showType="HERO",
                sort=int(definition["slot"]),
            )
            gift["reward"].update(
                type=1,
                content=json.dumps(
                    [{
                        "type": "HERO",
                        "code": int(definition["base_id"]),
                        "amount": 1,
                    }],
                    ensure_ascii=False,
                    separators=(",", ":"),
                ),
            )
            users.append(gift)
    result["users"] = users
    result["globals"] = []
    result["drawVo"].update(owner=long_id(record.player_id), logs={})
    result["spRecord"].update(comment=0, register=1)
    return result


def build_progress_rewards(schema: Schema, record: AccountRecord) -> dict[str, Any]:
    """Return the role's current progress with no invented live-service tiers."""
    result = default_object(
        schema, "com.eyu.mt.module.gift.model.ProgressRewardVo"
    )
    result.update(
        level=int(record.state.get("player", {}).get("level", 1)),
        levelTiers=[],
        loginDays=1,
        loginTiers=[],
        powerTiers=[],
        teamPower=0,
    )
    return result


def build_valid_activities(schema: Schema) -> dict[str, Any]:
    """The retired online activity service has no currently valid activities."""
    result = default_object(
        schema, "com.eyu.mt.module.activity.model.ValidActivityVo"
    )
    result.update(activitys=[], logs={})
    return result


def claim_user_gift(
    schema: Schema,
    record: AccountRecord,
    identifier: int,
) -> tuple[dict[str, Any], dict[str, Any]] | None:
    state = record.state
    claimed = {int(value) for value in state.get("claimed_gifts", [])}
    if identifier in claimed or "CN01BN01" not in state.get("battles", []):
        return None
    definition = next(
        (
            item
            for item in GUIDE_GIFTS
            if gift_id(record, int(item["slot"])) == identifier
        ),
        None,
    )
    if definition is None:
        return None

    reward = grant_hero(schema, record, state, int(definition["base_id"]))
    state.setdefault("claimed_gifts", []).append(identifier)
    return state, reward
