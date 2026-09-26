"""MsgElite (mod 61): elite dungeons (CH* campaigns).

The player commits up to three formation groups; they fight the elite team in
order and the enemy keeps its losses between groups.  Daily entries come from
BattleInfoConfig.dailyCount; extra entries are bought with jade at
buyTimesCost[n] (limit from Charge2Times ELITE tiers).  Enemy strength and
reward amounts are 推测值.
"""

from __future__ import annotations

import random
import time

from ..combat import BOSS, MAJOR, MINOR, enemy_roster, fight, make_fighter
from ..game import Context, GameError, as_id, charge_times, parse_json, route
from .battle import _unlocked

EMBATTLE_ERROR = -1
BATTLE_NOT_FOUND = -2
BLOCK_BY_PROGRESS = -10
ENTER_NOT_ENOUGH = -11
BUY_TIME_LIMIT = -13
BLOCK_BY_LEVEL = -17
ELITE_SCALE = 0.8  # 推测值


def _today() -> str:
    return time.strftime("%Y%m%d")


def _elite(ctx: Context) -> dict:
    elite = ctx.state.setdefault("elite", {"battles": [], "counts": {}, "buys": {}, "day": ""})
    if elite.get("day") != _today():
        elite.update(counts={}, buys={}, day=_today())
        ctx.save()
    return elite


def _battle(ctx: Context, battle_id: str) -> dict:
    battle = ctx.config.battles.get(str(battle_id))
    if battle is None or not str(battle_id).startswith("CH"):
        raise GameError(BATTLE_NOT_FOUND, "elite battle")
    return battle


def _remaining(ctx: Context, battle: dict) -> int:
    elite = _elite(ctx)
    total = int(battle.get("dailyCount") or 0) + int(elite["buys"].get(battle["id"], 0))
    return total - int(elite["counts"].get(battle["id"], 0))


@route(61, 1)  # PROGRESS
def progress(ctx: Context, req: dict):
    elite = _elite(ctx)
    return {"activeBuys": {}, "activeCounts": {},
            "battles": list(elite["battles"]),
            "campaigns": list(ctx.state.get("elite_campaigns", []))}


@route(61, 8)  # GET_BATTLES_TIMES
def battles_times(ctx: Context, req: dict):
    elite = _elite(ctx)
    return {"battleBuys": {"ELITE": {k: int(v) for k, v in elite["buys"].items()}},
            "battleCounts": {"ELITE": {k: int(v) for k, v in elite["counts"].items()}}}


def _fight(ctx: Context, battle: dict, groups: list[list[list[int]]]):
    level = max(1, int(battle.get("level") or 1))
    enemies = [make_fighter(ctx.config, slot, base, level, role,
                            scale=ELITE_SCALE * (2.0 if role == BOSS else 1.0))
               for slot, base, role in enemy_roster(ctx.config, battle["id"], 0, 1, count=3)]
    triggers, won = [], False
    rng = random.Random()
    for index, grid in enumerate(groups):
        attackers = []
        for r, row in enumerate(grid):
            for c, card_id in enumerate(row):
                card = ctx.card(card_id) if card_id else None
                if card_id and card is None:
                    raise GameError(EMBATTLE_ERROR, "card not owned")
                if card:
                    attackers.append(make_fighter(ctx.config, r * 2 + c, int(card["base_id"]),
                                                  int(card.get("level", 1)),
                                                  MAJOR if not attackers else MINOR,
                                                  int(card.get("power_skill") or 0)))
        if not attackers:
            continue
        won, report = fight(ctx.config, attackers, [e for e in enemies if e.alive], rng)
        triggers.append({"coins": 0, "drops": [], "enemyNum": sum(1 for e in enemies if e.alive),
                         "index": index, "reports": [report], "success": won})
        if won:
            break
    if not triggers:
        raise GameError(EMBATTLE_ERROR, "empty formation")
    return won, triggers


def _settle(ctx: Context, battle: dict, won: bool):
    ledger = ctx.ledger()
    if not won:
        return ledger
    elite = _elite(ctx)
    first = battle["id"] not in elite["battles"]
    if first:
        elite["battles"].append(battle["id"])
        same = [b["id"] for b in ctx.config.rows("BattleInfoConfig")
                if b["campaignId"] == battle["campaignId"]]
        if all(b in elite["battles"] for b in same):
            ctx.state.setdefault("elite_campaigns", []).append(battle["campaignId"])
    elite["counts"][battle["id"]] = int(elite["counts"].get(battle["id"], 0)) + 1
    level = max(1, int(battle.get("level") or 1))
    ledger.pay_action_point(int(battle.get("cost") or 0))
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": 200 + level * 80})  # 推测值
    ledger.grant({"type": "EXP", "code": 0, "amount": level * 15})              # 推测值
    for spec in parse_json(battle.get("itemDrop"), []):
        if first or random.random() < 0.5:
            ledger.grant(spec)
    ctx.save()
    return ledger


def _check(ctx: Context, battle: dict) -> None:
    if ctx.level < int(battle.get("level") or 1):
        raise GameError(BLOCK_BY_LEVEL, "level")
    prev = battle.get("prevId")
    if prev and prev not in _elite(ctx)["battles"]:
        raise GameError(BLOCK_BY_PROGRESS, "previous elite battle")
    if not prev and not _unlocked(ctx, battle):
        raise GameError(BLOCK_BY_PROGRESS, "previous elite campaign")
    if _remaining(ctx, battle) <= 0:
        raise GameError(ENTER_NOT_ENOUGH, "no entries left")


@route(61, 2)  # MULTI_ACTION {battleId, embattle: groups, quick}
def multi_action(ctx: Context, req: dict):
    battle = _battle(ctx, req.get("battleId"))
    _check(ctx, battle)
    groups = [[[as_id(v) for v in row] for row in grid] for grid in req.get("embattle") or []]
    won, triggers = _fight(ctx, battle, groups)
    ledger = _settle(ctx, battle, won)
    return {"battleId": battle["id"], "costAndReward": ledger.cost_and_reward(),
            "finished": True, "groupNum": len(triggers), "hasDemog": False,
            "triggers": triggers}


@route(61, 9)  # QUICK_ADVANCE {advanceCount, battleId}: sweep cleared elite
def quick_advance(ctx: Context, req: dict):
    battle = _battle(ctx, req.get("battleId"))
    if battle["id"] not in _elite(ctx)["battles"]:
        raise GameError(BLOCK_BY_PROGRESS, "sweep needs a cleared battle")
    count = max(1, int(req.get("advanceCount") or 1))
    ledger = None
    for _ in range(count):
        _check(ctx, battle)
        step = _settle(ctx, battle, True)
        if ledger is None:
            ledger = step
    return {"assistant": None, "battleId": battle["id"],
            "exitVo": {"costAndReward": ledger.cost_and_reward(), "failedTimes": 0, "hasDemog": False},
            "failed": False, "finished": True}


@route(61, 6)  # BUY_TIMES {battleId}
def buy_times(ctx: Context, req: dict):
    battle = _battle(ctx, req.get("battleId"))
    elite = _elite(ctx)
    bought = int(elite["buys"].get(battle["id"], 0))
    prices = parse_json(battle.get("buyTimesCost"), [])
    # buyTimesCost lists the price of each purchase; Charge2Times ELITE adds more.
    limit = len(prices) + charge_times(ctx, "ELITE", 0)
    if bought >= limit:
        raise GameError(BUY_TIME_LIMIT, "buy limit")
    ledger = ctx.ledger()
    ledger.pay_jade(int(prices[min(bought, len(prices) - 1)]), ctx.config.value("ELITE:BUY_TYPE"))
    elite["buys"][battle["id"]] = bought + 1
    ctx.save()
    return {"costResults": ledger.costs, "hasBuyTimes": bought + 1,
            "times": _remaining(ctx, battle)}


@route(61, 7)  # RECORD
def record(ctx: Context, req: dict):
    return []


@route(61, 10)  # FIRST_RECORD
def first_record(ctx: Context, req: dict):
    return []
