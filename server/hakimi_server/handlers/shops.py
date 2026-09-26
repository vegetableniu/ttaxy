"""Refreshing shop rooms sharing one implementation:
宝阁 treasureroom (53), 神秘商店 secretshop (57), 宝石屋 gemroom (70),
兑换商店 exchangeshop (85), 宝店 preciousroom (91), 糖果屋 sweethouse (79),
仙缘斋 cultivateshop (81).

Each room shows N goods (position -> goods id) drawn from the goods table
configured in server_settings.json "shops"; buying pays the row's costTypes
(jade / copper) or the room's own currency; refresh costs jade.
"""

from __future__ import annotations

import random
import time

from ..game import Context, GameError, now_ms, parse_json, route
from ..settings import setting
from .player import show_spec

ALREADY = -3
NOT_FOUND = -2


def _conf(kind: str) -> dict:
    return setting(f"shops.{kind}", {}) or {}


def _rows(ctx: Context, kind: str) -> dict:
    return {int(r["id"]): r for r in ctx.config.rows(_conf(kind).get("table", "")) if "id" in r}


def _positions(ctx: Context, kind: str) -> int:
    conf = _conf(kind)
    value = ctx.config.value(conf["positions"], None) if conf.get("positions") else None
    if isinstance(value, dict):
        value = next(iter(value.values()))
    return int(value or conf.get("positions_default", 6))


def _room(ctx: Context, kind: str, key: str = "") -> dict:
    rooms = ctx.state.setdefault("rooms", {})
    room = rooms.get(kind + key)
    day = time.strftime("%Y%m%d%H")[:10]
    if room is None or room.get("hour") != day[:8] + str(int(day[8:]) // 2):
        room = {"items": _draw(ctx, kind), "got": [], "refresh": 0,
                "hour": day[:8] + str(int(day[8:]) // 2), "time": now_ms()}
        rooms[kind + key] = room
        ctx.save()
    return room


def _draw(ctx: Context, kind: str) -> dict:
    ids = list(_rows(ctx, kind))
    picks = random.sample(ids, min(_positions(ctx, kind), len(ids))) if ids else []
    return {str(i + 1): gid for i, gid in enumerate(picks)}


def _currency(ctx: Context, kind: str) -> int:
    name = _conf(kind).get("currency", "JADE")
    return ctx.counter(f"reward_{name}_0") if name not in ("JADE", "COPPER") else 0


def _buy(ctx: Context, kind: str, room: dict, position: int):
    gid = room["items"].get(str(position))
    if gid is None:
        raise GameError(NOT_FOUND, "no goods")
    if position in room["got"]:
        raise GameError(ALREADY, "already bought")
    row = _rows(ctx, kind)[int(gid)]
    ledger = ctx.ledger()
    types = parse_json(row.get("costTypes"), [])
    cost = int(row.get("cost") or 0)
    if "GOLD" in types or "GIFT" in types:
        ledger.pay_jade(cost, types)
    elif types:
        for t in types:
            ledger.pay_currency(t, cost)
    elif cost:
        name = _conf(kind).get("currency", "JADE")
        if name == "JADE":
            ledger.pay_jade(cost)
        elif ctx.counter(f"reward_{name}_0") < cost:
            raise GameError(-4, "room currency")
        else:
            ctx.add_counter(f"reward_{name}_0", -cost)
    ledger.pay_costs(parse_json(row.get("otherCost"), []))
    ledger.grant(show_spec(row.get("showType"), row.get("showId"), row.get("amount") or 1))
    room["got"].append(position)
    ctx.save()
    return ledger


def _refresh(ctx: Context, kind: str, room: dict, paid: bool = True):
    ledger = ctx.ledger()
    if paid:
        ledger.pay_jade(int(_conf(kind).get("refresh_cost", 20)))
    room.update(items=_draw(ctx, kind), got=[], refresh=int(room["refresh"]) + 1, time=now_ms())
    ctx.save()
    return ledger


def _treasures(room: dict) -> dict:
    return {int(k): int(v) for k, v in room["items"].items()}


def _next(room: dict) -> int:
    return int(room["time"]) + 2 * 3_600_000


# ---- 53 treasureroom
@route(53, 1)
def treasureroom_load(ctx, req):
    r = _room(ctx, "treasureroom")
    return {"gotTreasures": r["got"], "refreshTimes": r["refresh"], "roomCurrency": _currency(ctx, "treasureroom"),
            "time": _next(r), "treasures": _treasures(r)}


@route(53, 2)
def treasureroom_refresh(ctx, req):
    r = _room(ctx, "treasureroom")
    led = _refresh(ctx, "treasureroom", r)
    return {"costResults": led.costs, "nextTime": _next(r), "times": r["refresh"], "treasures": _treasures(r)}


@route(53, 3)
def treasureroom_exchange(ctx, req):
    r = _room(ctx, "treasureroom")
    led = _buy(ctx, "treasureroom", r, int(req.get("position") or 0))
    return {"costResults": led.costs, "gotTreasures": r["got"], "rewardResults": led.rewards,
            "roomCurrency": _currency(ctx, "treasureroom"), "treasures": _treasures(r)}


# ---- 57 secretshop
@route(57, 1)
def secret_load(ctx, req):
    r = _room(ctx, "secretshop")
    return {"currency": _currency(ctx, "secretshop"), "gotTreasures": r["got"], "refreshTimes": r["refresh"],
            "time": _next(r), "treasures": _treasures(r)}


@route(57, 2)
def secret_refresh(ctx, req):
    r = _room(ctx, "secretshop")
    led = _refresh(ctx, "secretshop", r)
    return {"costResults": led.costs, "currency": _currency(ctx, "secretshop"), "nextTime": _next(r),
            "times": r["refresh"], "treasures": _treasures(r)}


@route(57, 3)
def secret_exchange(ctx, req):
    r = _room(ctx, "secretshop")
    led = _buy(ctx, "secretshop", r, int(req.get("position") or 0))
    return {"costResults": led.costs, "gotTreasures": r["got"], "rewardResults": led.rewards,
            "roomCurrency": _currency(ctx, "secretshop"), "treasures": _treasures(r)}


# ---- 70 gemroom
@route(70, 1)
def gem_load(ctx, req):
    r = _room(ctx, "gemroom")
    cool = int(r.get("cool", 0))
    return {"coolState": cool > now_ms(), "coolTime": cool, "gotTreasures": r["got"],
            "refreshTimes": r["refresh"], "treasures": _treasures(r)}


@route(70, 2)
def gem_refresh(ctx, req):
    r = _room(ctx, "gemroom")
    if int(r.get("cool", 0)) > now_ms():
        raise GameError(-5, "cool time")
    _refresh(ctx, "gemroom", r, paid=False)
    r["cool"] = now_ms() + int(ctx.config.value("GEMROOM:REFRESH_ADD_COOLTIME", 1)) * 60_000
    ctx.save()
    return {"coolState": True, "coolTime": r["cool"], "times": r["refresh"], "treasures": _treasures(r)}


@route(70, 3)
def gem_exchange(ctx, req):
    r = _room(ctx, "gemroom")
    led = _buy(ctx, "gemroom", r, int(req.get("position") or 0))
    return {"costResults": led.costs, "gotTreasures": r["got"], "rewardResults": led.rewards,
            "treasures": _treasures(r)}


@route(70, 4)
def gem_clear(ctx, req):
    r = _room(ctx, "gemroom")
    led = ctx.ledger()
    if int(r.get("cool", 0)) > now_ms():
        led.pay_jade(int(ctx.config.value("GEMROOM:CLEAR_COOL_TIME_COST", 20)))
        r["cool"] = 0
        ctx.save()
    return led.costs


# ---- 85 exchangeshop
@route(85, 1)
def exshop_load(ctx, req):
    r = _room(ctx, "exchangeshop")
    return {"exhangeTimes": {}, "gotTreasures": r["got"], "refreshTimes": r["refresh"],
            "time": _next(r), "treasures": _treasures(r)}


@route(85, 2)
def exshop_refresh(ctx, req):
    r = _room(ctx, "exchangeshop")
    led = _refresh(ctx, "exchangeshop", r, paid=bool(req.get("currency")))
    return {"costResults": led.costs, "nextTime": _next(r), "times": r["refresh"], "treasures": _treasures(r)}


@route(85, 3)
def exshop_exchange(ctx, req):
    r = _room(ctx, "exchangeshop")
    led = _buy(ctx, "exchangeshop", r, int(req.get("position") or 0))
    return {"costResults": led.costs, "gotTreasures": r["got"], "rewardResults": led.rewards,
            "treasures": _treasures(r)}


# ---- 91 preciousroom (per mallId 201..210)
@route(91, 1)
def precious_load(ctx, req):
    r = _room(ctx, "preciousroom", str(req.get("mallId") or 0))
    return {"gotTreasures": r["got"], "refreshTimes": r["refresh"], "time": _next(r), "treasures": _treasures(r)}


@route(91, 2)
def precious_exchange(ctx, req):
    r = _room(ctx, "preciousroom", str(req.get("mallId") or 0))
    led = _buy(ctx, "preciousroom", r, int(req.get("position") or 0))
    return {"costResults": led.costs, "gotTreasures": r["got"], "rewardResults": led.rewards,
            "roomCurrency": 0, "treasures": _treasures(r)}


@route(91, 3)
def precious_refresh(ctx, req):
    r = _room(ctx, "preciousroom", str(req.get("mallId") or 0))
    led = _refresh(ctx, "preciousroom", r)
    return {"costResults": led.costs, "nextTime": _next(r), "times": r["refresh"], "treasures": _treasures(r)}


# ---- 79 sweethouse
def _sweets(ctx) -> dict:
    return {i: ctx.counter(f"reward_SWEET_{i}") for i in range(4)}


@route(79, 1)
def sweet_info(ctx, req):
    r = _room(ctx, "sweethouse")
    return {"authoRefreshDate": _next(r), "costRefreshTimes": r["refresh"], "exchange": r["got"],
            "onItems": _treasures(r), "sweets": _sweets(ctx)}


@route(79, 2)
def sweet_refresh(ctx, req):
    r = _room(ctx, "sweethouse")
    led = _refresh(ctx, "sweethouse", r)
    return {"authoRefreshDate": _next(r), "costRefreshTimes": r["refresh"], "costResults": led.costs,
            "exchange": r["got"], "onItems": _treasures(r)}


@route(79, 3)
def sweet_exchange(ctx, req):
    r = _room(ctx, "sweethouse")
    led = _buy(ctx, "sweethouse", r, int(req.get("position") or 0))
    return {"costResults": led.costs, "exchange": r["got"], "onItems": _treasures(r),
            "rewardResults": led.rewards, "sweets": _sweets(ctx)}


# ---- 81 cultivateshop (floors 1..5)
@route(81, 1)
def cshop_info(ctx, req):
    floor = str(req.get("_") or 1)
    r = _room(ctx, "cultivateshop", floor)
    return {"autoRefreshDate": _next(r), "costRefreshTimes": r["refresh"], "exchanges": r["got"],
            "onItems": _treasures(r)}


@route(81, 2)
def cshop_refresh(ctx, req):
    floor = str(req.get("_") or 1)
    r = _room(ctx, "cultivateshop", floor)
    costs = ctx.config.value("CULTIVATESHOP:BUY_REFRESH_COSTS", [20])
    led = ctx.ledger()
    led.pay_jade(int(costs[min(int(r["refresh"]), len(costs) - 1)]))
    r.update(items=_draw(ctx, "cultivateshop"), got=[], refresh=int(r["refresh"]) + 1)
    ctx.save()
    return {"costRefreshTimes": r["refresh"], "costResults": led.costs, "exchanges": r["got"],
            "onItems": _treasures(r)}


@route(81, 3)
def cshop_exchange(ctx, req):
    r = _room(ctx, "cultivateshop", str(req.get("floor") or 1))
    led = _buy(ctx, "cultivateshop", r, int(req.get("position") or 0))
    return {"autoRefreshDate": _next(r), "costResults": led.costs, "exchanges": r["got"],
            "onItems": _treasures(r), "rewardResults": led.rewards}
