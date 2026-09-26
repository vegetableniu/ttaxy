"""Account-login response builders backed by original protocol types."""

from __future__ import annotations

import time
from typing import Any

from .defaults import default_object, long_id
from .protocol import Schema
from .gift import hero_vo


LOGIN_INFO = "com.eyu.mt.module.account.model.LoginInfoVo"


def _point(schema: Schema, amount: int, now_ms: int) -> dict[str, Any]:
    value = default_object(schema, "com.eyu.mt.module.point.manager.PointValue")
    value.update(
        point=amount,
        refreshTime=now_ms,
        exchangeCount=0,
        exchangeTime=0,
        extraTime=0,
    )
    return value


def build_login_info(
    schema: Schema,
    *,
    account_name: str,
    role_name: str,
    player_id: int = 10001,
    hero_id: int = 100001,
    starter_hero: int = 1001,
    created_ms: int | None = None,
    state: dict[str, Any] | None = None,
) -> dict[str, Any]:
    """Build a conservative level-1 state without debug unlocks or free currency."""
    now_ms = int(time.time() * 1000)
    created_ms = created_ms or now_ms
    state = state or {}
    player_state = state.get("player", {})
    wallet_state = state.get("wallet", {})
    point_state = state.get("action_points", {})
    info = default_object(schema, LOGIN_INFO)

    info["account"].update(
        id=long_id(player_id),
        name=account_name,
        state=0,
        online=True,
        createdOn=created_ms,
        loginOn=now_ms,
        logoutOn=now_ms,
        dayByContinuous=1,
        dayByTotal=1,
    )
    info["player"].update(
        id=long_id(player_id),
        name=role_name,
        level=int(player_state.get("level", 1)),
        exp=int(player_state.get("exp", 0)),
        leadership=15,
        baseId=starter_hero,
        rank=0,
        rename=False,
    )
    info["wallet"].update(
        copper=0,
        gold=0,
        gift=0,
        stone=0,
        inter=0,
        friendship=0,
        fragment=0,
        coupon=0,
        exploit=0,
        orange=0,
        purple=0,
        totalCharge=0,
        stageCharges={},
    )
    info["wallet"].update(wallet_state)
    info["actionPoint"]["points"] = {
        0: _point(schema, int(point_state.get("0", 100)), now_ms),
        1: _point(schema, int(point_state.get("1", 10)), now_ms),
        2: _point(schema, int(point_state.get("2", 0)), now_ms),
    }

    hero = default_object(schema, "com.eyu.mt.module.hero.model.HeroVo")
    hero.update(
        id=long_id(hero_id),
        baseId=starter_hero,
        exp=0,
        level=1,
        locked=False,
        powerSkill=0,
        skillExp=0,
    )
    extra_heroes = [hero_vo(schema, card) for card in state.get("heroes", [])]
    info["heros"].update(
        extendCount=0,
        extendLimit=20,
        heros=[hero, *extra_heroes],
        leader=long_id(hero_id),
        score=[],
    )
    empty_id = long_id(0)
    group = default_object(schema, "com.eyu.mt.module.hero.model.HeroGroupVo")
    group.update(
        groupId=1,
        leaderId=long_id(hero_id),
        embattles=[
            [long_id(hero_id), empty_id],
            [empty_id, empty_id],
            [empty_id, empty_id],
        ],
    )
    info["groupVo"].update(curGroupId=1, groups=[group])
    info["friendPack"].update(apply=False, extendCount=0, extendLimit=10, friends=[])
    info["progressVo"].update(
        battles=list(state.get("battles", [])),
        campaigns=list(state.get("campaigns", [])),
        dailyCounts=dict(state.get("daily_counts", {})),
        current=None,
    )
    info["systemTime"] = now_ms
    # The stock 1.0.8.0 package reads this from assets/ini/misc.dat.  The
    # original Lua-side oracle reports 1000, and Login.OnLoginInfo rejects
    # any different value before initializing player state.
    info["asset"] = 1000
    info["state"] = 0
    info["lotteryLevel"] = 0
    info["artifactLevel"] = 0
    info["hasNewMail"] = False
    info["hasReward"] = False
    info["hasAchieve"] = False
    info["resetPlayerName"] = False
    return info
