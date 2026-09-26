"""MsgArtifact (mod 45): 神器 (BeeEffGee) — inject soul stones to level up.

BeeEffGeeLevelSetting[level]: progress needed and the soul-stone type that
level consumes; each stone adds BEEEFFGEE:<TYPE>_SOUL_STONE_INJECT_PROGRESS
(NORMAL uses SOUL_STONE_INJECT_PROGRESS × normalProgressFactor) with a
BEEEFFGEE:SOUL_CRIT_RATE chance of ×CRIT_PROGRESS_MULTIPLE.  Stones are bought
with jade (SoulstonePackageSetting) or exchanged (StoneExchangePackage).
"""

from __future__ import annotations

import random

from ..bots import BOT_BASE, bot
from ..defaults import long_id
from ..game import Context, GameError, now_ms, parse_json, route
from .player import show_spec

STONES = ["NORMAL", "PRIMARY", "MIDDLE", "SENIOR"]
FIELDS = {"NORMAL": "normalSoulStone", "PRIMARY": "primarySoulStone",
          "MIDDLE": "middleSoulStone", "SENIOR": "seniorSoulStone"}
ALREADY_MAX = -600
NOT_ENOUGH_STONE = -606
CURRENCY_NOT_ENOUGH = -605
NO_PACKAGE = -604
EXCHANGE_LIMIT = -607


def _art(ctx: Context) -> dict:
    return ctx.state.setdefault("artifact", {"level": 0, "progress": 0, "exchanged": 0})


def stone_count(ctx: Context, kind: str) -> int:
    return ctx.counter(f"reward_SOUL_STONE_{STONES.index(kind)}")


def _vo(ctx: Context) -> dict:
    art = _art(ctx)
    vo = {"level": int(art["level"]), "progress": int(art["progress"])}
    for kind, field in FIELDS.items():
        vo[field] = stone_count(ctx, kind)
    return vo


def _level_row(ctx: Context, level: int) -> dict | None:
    return ctx.config.index("BeeEffGeeLevelSetting").get(int(level))


def _inject_one(ctx: Context, auto_buy: bool, ledger) -> tuple[int, bool, str]:
    art = _art(ctx)
    row = _level_row(ctx, art["level"])
    if row is None:
        raise GameError(ALREADY_MAX, "max level")
    kind = row["stoneType"]
    for candidate in ("NORMAL", kind):  # plain stones are always accepted
        if stone_count(ctx, candidate) > 0:
            kind = candidate
            break
    else:
        if not auto_buy:
            raise GameError(NOT_ENOUGH_STONE, "no soul stone")
        ledger.pay_jade(int(ctx.config.value("BEEEFFGEE:SOUL_STONE_PRICE", 25)),
                        ctx.config.value("BEEEFFGEE:SOUL_STONE_COST_TYPE"))
        ctx.add_counter("reward_SOUL_STONE_0", 1)
        kind = "NORMAL"
    ctx.add_counter(f"reward_SOUL_STONE_{STONES.index(kind)}", -1)
    base = int(ctx.config.value(f"BEEEFFGEE:{kind}_SOUL_STONE_INJECT_PROGRESS"
                                if kind != "NORMAL" else "BEEEFFGEE:SOUL_STONE_INJECT_PROGRESS", 100))
    if kind == "NORMAL":
        base = int(base * float(row.get("normalProgressFactor") or 1))
    crit = random.random() < float(ctx.config.value("BEEEFFGEE:SOUL_CRIT_RATE", 0.12))
    gain = base * (int(ctx.config.value("BEEEFFGEE:CRIT_PROGRESS_MULTIPLE", 10)) if crit else 1)
    art["progress"] = int(art["progress"]) + gain
    while _level_row(ctx, art["level"]) and art["progress"] >= int(_level_row(ctx, art["level"])["progress"]):
        art["progress"] -= int(_level_row(ctx, art["level"])["progress"])
        art["level"] = int(art["level"]) + 1
    if _level_row(ctx, art["level"]) is None:
        art["progress"] = 0
    ctx.save()
    return gain, crit, kind


@route(45, 1)  # ENTER
def enter(ctx: Context, req: dict):
    return _vo(ctx)


@route(45, 6)  # INJECT_SOUL_ONCE {autoBuy}
def inject_once(ctx: Context, req: dict):
    ledger = ctx.ledger()
    _, crit, kind = _inject_one(ctx, bool(req.get("autoBuy")), ledger)
    art = _art(ctx)
    return {"costResult": ledger.costs, "critNum": int(crit), "level": int(art["level"]),
            "number": stone_count(ctx, kind), "progress": int(art["progress"]),
            "stoneType": STONES.index(kind)}


@route(45, 7)  # INJECT_SOUL_REPEATEDLY {autoBuy}
def inject_repeatedly(ctx: Context, req: dict):
    ledger = ctx.ledger()
    times = int(ctx.config.value("BEEEFFGEE:PROGRESS_REPEATE_NUM", 50))
    crits = done = 0
    stop = 2  # SUCCESS
    start_level = int(_art(ctx)["level"])
    for _ in range(times):
        try:
            _, crit, _ = _inject_one(ctx, bool(req.get("autoBuy")), ledger)
        except GameError as error:
            stop = 0 if error.code == ALREADY_MAX else (3 if error.code == NOT_ENOUGH_STONE else 1)
            break
        crits += int(crit)
        done += 1
        if int(_art(ctx)["level"]) > start_level and \
                ctx.config.value("BEEEFFGEE:STOP_MULTI_INJECT_WHEN_MAX_LEVEL", False):
            break
    if done == 0:
        raise GameError(NOT_ENOUGH_STONE, "no soul stone")
    art = _art(ctx)
    vo = {"costResult": ledger.costs, "critNum": crits, "haveInjected": done,
          "level": int(art["level"]), "progress": int(art["progress"]),
          "soulStoneNumber": stone_count(ctx, "NORMAL"), "stopType": stop}
    for kind in ("PRIMARY", "MIDDLE", "SENIOR"):
        vo[FIELDS[kind]] = stone_count(ctx, kind)
    return vo


@route(45, 2)  # INJECT_SOULSTONE (legacy, no content)
def inject_legacy(ctx: Context, req: dict):
    _inject_one(ctx, False, ctx.ledger())
    return None


@route(45, 3)  # BUY_INJECT_SOULSTONE (legacy, no content)
def buy_inject_legacy(ctx: Context, req: dict):
    _inject_one(ctx, True, ctx.ledger())
    return None


@route(45, 4)  # BUY_SOULSTONE {id}
def buy_soulstone(ctx: Context, req: dict):
    row = ctx.config.index("SoulstonePackageSetting").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(NO_PACKAGE, "no package")
    ledger = ctx.ledger()
    ledger.pay_jade(int(row.get("onSaleCost") or row["cost"]),
                    ctx.config.value("BEEEFFGEE:SOUL_STONE_COST_TYPE"))
    amount = int(row["stoneCount"]) + int(row.get("giftCount") or 0)
    ledger.grant({"type": "SOUL_STONE", "code": STONES.index(row["soulStoneType"]), "amount": amount})
    return {"costResults": ledger.costs, "rewardResults": ledger.rewards}


def _exchange(ctx: Context, row_id: int, count: int):
    row = ctx.config.index("StoneExchangePackage").get(int(row_id))
    if row is None:
        raise GameError(NO_PACKAGE, "no package")
    if count <= 0:
        raise GameError(-608, "count")
    art = _art(ctx)
    if int(art.get("exchanged", 0)) + count > int(ctx.config.value("BEEEFFGEE:SOUL_STONE_EXCHANGE_LIMIT", 50)):
        raise GameError(EXCHANGE_LIMIT, "limit")
    kind = row["costStoneType"]
    cost = int(row["costNum"]) * count
    if stone_count(ctx, kind) < cost:
        raise GameError(NOT_ENOUGH_STONE, "stones")
    ctx.add_counter(f"reward_SOUL_STONE_{STONES.index(kind)}", -cost)
    art["exchanged"] = int(art.get("exchanged", 0)) + count
    ledger = ctx.ledger()
    for _ in range(count):
        ledger.grant(show_spec(row["showType"], row["showId"], row["name"].split("*")[-1]))
    return {"cost": cost, "costType": STONES.index(kind), "rewardResults": ledger.rewards}


@route(45, 8)  # SOUL_STONE_EXCHANGE {id}
def stone_exchange(ctx: Context, req: dict):
    return _exchange(ctx, int(req.get("id") or 0), 1)


@route(45, 9)  # SOUL_STONE_EXCHANGE_BY_TYPE {count, id}
def stone_exchange_by_type(ctx: Context, req: dict):
    return _exchange(ctx, int(req.get("id") or 0), int(req.get("count") or 0))


@route(45, 5)  # GET_RANK_LIST
def rank_list(ctx: Context, req: dict):
    rows = []
    art = _art(ctx)
    size = int(ctx.config.value("BEEEFFGEE:RANK", 10))
    for rank in range(1, size + 1):
        b = bot(ctx.config, BOT_BASE + 700 + rank, 80 - rank)
        level = max(0, 10 - rank)
        rows.append({"baseId": b.leader, "id": long_id(b.id), "level": level, "name": b.name,
                     "palyerLevel": b.level, "progress": 0, "rank": rank, "time": now_ms()})
    return rows
