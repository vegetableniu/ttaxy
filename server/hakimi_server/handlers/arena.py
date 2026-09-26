"""MsgArena (24, 竞技场) and MsgPvp (29, 封神战) against local bots.

Arena: 5 bots near the player's level (ARENA:MAX_MATCH_PLAYER), free defies
per day ARENA:MAX_FREE_TIMES, extra defies at ARENA:BUY_TIMES_COST, a win adds
LevelConfig.integral[section] points spendable in IntegralExchange.
PVP: a ladder of PVP:VIRTUAL_PLAYER_NUM ranked bots; beating a higher rank
swaps places; PVP:DEFY_COOL_DOWN seconds between defies.
Win money/integral formulas beyond the tables are 推测值.
"""

from __future__ import annotations

import random
import time

from ..bots import BOT_BASE, bot, bots_near
from ..combat import MAJOR, MINOR, fight, make_fighter
from ..defaults import long_id
from ..settings import setting
from ..game import Context, GameError, as_id, now_ms, route

ARENA_LOCK = "ARENA"


def _today() -> str:
    return time.strftime("%Y%m%d")


def _groups_fighters(ctx: Context, groups) -> list[list]:
    teams = []
    for grid in groups or []:
        team = []
        for r, row in enumerate(grid):
            for c, value in enumerate(row):
                card = ctx.card(as_id(value)) if as_id(value) else None
                if card:
                    from .battle import card_fighter
                    team.append(card_fighter(ctx, r * 2 + c, card, MAJOR if not team else MINOR))
        if team:
            teams.append(team)
    return teams


def _bot_team(ctx: Context, b) -> list:
    return [make_fighter(ctx.config, 6 + slot, base, level, MAJOR if i == 0 else MINOR)
            for i, (slot, base, level) in enumerate(b.cards)]


def _duel(ctx: Context, groups, b) -> tuple[bool, list[bytes], int]:
    teams = _groups_fighters(ctx, groups)
    if not teams:
        raise GameError(-15, "empty formation")
    enemy = _bot_team(ctx, b)
    reports, won = [], False
    rng = random.Random()
    for team in teams:
        won, report = fight(ctx.config, team, [e for e in enemy if e.alive], rng)
        reports.append(report)
        if won:
            break
    return won, reports, len(teams)


def my_power(ctx: Context) -> int:
    from .hero import formation_power
    return formation_power(ctx)


# ------------------------------------------------------------------ arena
def _arena(ctx: Context) -> dict:
    arena = ctx.state.setdefault("arena", {"integral": int(ctx.config.value("ARENA:INIT_INTEGRAL", 10)),
                                           "total": 0, "day": "", "used": 0, "bought": 0,
                                           "cool": 0, "seed": 0, "first": False})
    if arena.get("day") != _today():
        arena.update(day=_today(), used=0, bought=0)
        ctx.save()
    return arena


def _match(ctx: Context) -> list:
    arena = _arena(ctx)
    count = int(ctx.config.value("ARENA:MAX_MATCH_PLAYER", 5))
    return bots_near(ctx.config, ctx.level, count, f"arena:{ctx.player_id}:{arena['seed']}")


def _match_vo(ctx: Context) -> dict:
    arena = _arena(ctx)
    free = int(ctx.config.value("ARENA:MAX_FREE_TIMES", 10))
    players = [{"battleEffect": b.power(ctx.config), "carry": False, "id": long_id(b.id),
                "leaderBaseId": b.leader, "level": b.level, "name": b.name,
                "socialStatus": 0, "star": 1, "state": False} for b in _match(ctx)]
    cool = max(0, int(arena["cool"]) - now_ms()) // 1000
    return {"battleEffect": my_power(ctx), "coolState": cool > 0, "coolTime": cool,
            "hasBuyTimes": int(arena["bought"]), "integral": int(arena["integral"]),
            "leaveBuyTimes": len(ctx.config.value("ARENA:BUY_TIMES_COST", [])) - int(arena["bought"]),
            "playerList": players, "rank": _arena_rank(ctx),
            "times": free + int(arena["bought"]) - int(arena["used"]),
            "totalIntegral": int(arena["total"])}


def _arena_rank(ctx: Context) -> int:
    return max(1, 2000 - int(_arena(ctx)["total"]) * 3)  # 推测值: rank from total integral


@route(24, 1)  # MATCH_LIST
def match_list(ctx: Context, req: dict):
    return _match_vo(ctx)


@route(24, 3)  # MANUAL_REFRESH_LIST
def manual_refresh(ctx: Context, req: dict):
    ledger = ctx.ledger()
    ledger.pay_jade(int(ctx.config.value("ARENA:REFRESH_COST", 20)),
                    ctx.config.value("ARENA:REFRESH_CURRENCY_TYPES"))
    _arena(ctx)["seed"] = int(_arena(ctx)["seed"]) + 1
    ctx.save()
    return _match_vo(ctx)


@route(24, 2)  # DEFY_MATCH {embattle, id}
def arena_defy(ctx: Context, req: dict):
    arena = _arena(ctx)
    free = int(ctx.config.value("ARENA:MAX_FREE_TIMES", 10))
    if int(arena["used"]) >= free + int(arena["bought"]):
        raise GameError(-16, "no defy times")
    if int(arena["cool"]) > now_ms():
        raise GameError(-7, "cooling down")
    target = as_id(req.get("id"))
    b = next((m for m in _match(ctx) if m.id == target), None)
    if b is None:
        raise GameError(-6, "player not in list")
    won, reports, groups = _duel(ctx, req.get("embattle"), b)
    arena["used"] = int(arena["used"]) + 1
    arena["cool"] = now_ms() + int(ctx.config.value("ARENA:REFRESH_COOL_TIME", 30)) * 1000
    ledger = ctx.ledger()
    gained = 0
    if won:
        sections = ctx.config.levels.get(ctx.level, {}).get("integral") or "[6]"
        import json
        table = json.loads(sections) if isinstance(sections, str) else sections
        gained = int(table[min(len(table) - 1, random.randrange(len(table)))])
        arena["integral"] = int(arena["integral"]) + gained
        arena["total"] = int(arena["total"]) + gained
        ledger.grant({"type": "CURRENCY", "code": 0, "amount": int(setting("arena.win_copper_base", 1000)) + ctx.level * int(setting("arena.win_copper_per_level", 100))})
        arena["seed"] = int(arena["seed"]) + 1
    ctx.save()
    return {"costResult": ledger.costs, "groupNum": groups, "integral": gained,
            "matchPlayerList": _match_vo(ctx), "reports": reports, "rewards": ledger.rewards,
            "success": won, "targetArtifactLevel": 0, "targetGroupNum": 1}


@route(24, 4)  # INTEGRAL_EXCHANGE {id}
def integral_exchange(ctx: Context, req: dict):
    row = ctx.config.index("IntegralExchange").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-10, "no such reward")
    if not int(row["minLevel"]) <= ctx.level <= int(row["maxLevel"]):
        raise GameError(-12, "level")
    if int(ctx.wallet.get("totalCharge", 0)) < int(row.get("chargeAmount") or 0):
        raise GameError(-17, "charge")
    arena = _arena(ctx)
    if int(arena["integral"]) < int(row["integral"]):
        raise GameError(-9, "integral not enough")
    arena["integral"] = int(arena["integral"]) - int(row["integral"])
    ledger = ctx.ledger()
    ledger.grant_reward_id(row["rewardId"])
    ctx.save()
    return {"rewardResult": ledger.rewards, "totalIntegral": int(arena["integral"])}


def _lineup(ctx: Context, name: str, level: int, cards: list[tuple[int, int]]) -> dict:
    heroes = [{"baseId": base, "cultivateVo": None, "equipVos": [], "level": lv,
               "talismanVos": []} for base, lv in cards]
    return {"artifactLevel": 0, "battleEffect": 0, "buffs": [], "level": level, "name": name,
            "groups": [{"embattles": heroes, "groupId": 1,
                        "leaderBaseId": cards[0][0] if cards else 0,
                        "leaderLevel": cards[0][1] if cards else 1}]}


def _own_lineup(ctx: Context) -> dict:
    group = ctx.groups["groups"][0]
    cards = [ctx.card(v) for row in group["embattles"] for v in row if v]
    return _lineup(ctx, ctx.record.role_name, ctx.level,
                   [(int(c["base_id"]), int(c.get("level", 1))) for c in cards if c])


@route(24, 5)  # LINEUP_COMPARE {id}
def arena_compare(ctx: Context, req: dict):
    b = bot(ctx.config, as_id(req.get("id")))
    return {"enemy": _lineup(ctx, b.name, b.level, [(base, lv) for _, base, lv in b.cards]),
            "own": _own_lineup(ctx)}


@route(24, 6)  # CLEAR_COOL_TIME
def arena_clear_cool(ctx: Context, req: dict):
    arena = _arena(ctx)
    ledger = ctx.ledger()
    if int(arena["cool"]) > now_ms():
        ledger.pay_jade(int(ctx.config.value("ARENA:COOL_TIME_COST", 5)),
                        ctx.config.value("ARENA:COOL_TIME_COST_TYPE"))
        arena["cool"] = 0
        ctx.save()
    return ledger.costs


@route(24, 7)  # GET_RANK_LIST
def arena_rank_list(ctx: Context, req: dict):
    rows = []
    for rank in range(1, 11):
        b = bot(ctx.config, BOT_BASE + 500 + rank, 60 + (10 - rank) * 3)
        rows.append({"integral": 5000 - rank * 250, "leaderBaseId": b.leader, "level": b.level,
                     "rank": rank, "userName": b.name})
    return rows


@route(24, 8)  # BUY_DEFY_TIMES {num}
def arena_buy_times(ctx: Context, req: dict):
    arena = _arena(ctx)
    costs = ctx.config.value("ARENA:BUY_TIMES_COST", [10])
    num = max(1, int(req.get("num") or 1))
    ledger = ctx.ledger()
    for _ in range(num):
        bought = int(arena["bought"])
        if bought >= len(costs):
            raise GameError(-13, "buy limit")
        ledger.pay_jade(int(costs[bought]), ctx.config.value("ARENA:BUY_TIMES_COST_TYPES"))
        arena["bought"] = bought + 1
    ctx.save()
    free = int(ctx.config.value("ARENA:MAX_FREE_TIMES", 10))
    return {"costResults": ledger.costs, "hasBuyTimes": int(arena["bought"]),
            "times": free + int(arena["bought"]) - int(arena["used"])}


# -------------------------------------------------------------------- pvp
def _pvp(ctx: Context) -> dict:
    count = int(ctx.config.value("PVP:VIRTUAL_PLAYER_NUM", 100))
    return ctx.state.setdefault("pvp", {"rank": count + 1, "cool": 0, "records": [], "wins": []})


def _pvp_bot(ctx: Context, rank: int):
    count = int(ctx.config.value("PVP:VIRTUAL_PLAYER_NUM", 100))
    level = 60 + int((count - rank) * 0.6)
    return bot(ctx.config, BOT_BASE + 100_000 + rank, level)


def _pvp_match(ctx: Context) -> list[dict]:
    pvp = _pvp(ctx)
    mine = int(pvp["rank"])
    targets = [r for r in range(max(1, mine - 5), mine) if r >= 1][-5:] or [1]
    out = []
    for rank in targets:
        b = _pvp_bot(ctx, rank)
        out.append({"battleScore": b.power(ctx.config), "desId": 0, "id": long_id(b.id),
                    "leaderBaseId": b.leader, "level": b.level, "name": b.name, "rank": rank,
                    "virtual": True})
    return out


@route(29, 1)  # GET_PVP_INFO
def pvp_info(ctx: Context, req: dict):
    pvp = _pvp(ctx)
    return {"attacked": False, "attackedRecord": pvp["records"][-5:],
            "coolDown": max(0, int(pvp["cool"]) - now_ms()) // 1000,
            "matchList": _pvp_match(ctx), "winRanks": list(pvp["wins"])}


@route(29, 2)  # DEFY_MATCH {embattle, rank, targetId, targetRank}
def pvp_defy(ctx: Context, req: dict):
    lock = int(ctx.config.value("PVP:OPEN_LEVEL", 60))
    if ctx.level < lock:
        raise GameError(-8, "level")
    pvp = _pvp(ctx)
    if int(pvp["cool"]) > now_ms():
        raise GameError(-4, "cool down")
    target_rank = int(req.get("targetRank") or 0)
    if target_rank >= int(pvp["rank"]) or target_rank < 1:
        raise GameError(-5, "rank changed")
    b = _pvp_bot(ctx, target_rank)
    won, reports, groups = _duel(ctx, req.get("embattle"), b)
    old = int(pvp["rank"])
    ledger = ctx.ledger()
    if won:
        pvp["rank"] = target_rank
        if target_rank not in pvp["wins"]:
            pvp["wins"].append(target_rank)
    pvp["cool"] = now_ms() + int(ctx.config.value("PVP:DEFY_COOL_DOWN", 600)) * 1000
    ctx.save()
    return {"coolDown": int(ctx.config.value("PVP:DEFY_COOL_DOWN", 600)),
            "costAndReward": ledger.cost_and_reward(), "groupNum": groups,
            "leaderBaseId": b.leader, "matchList": _pvp_match(ctx), "oldRank": old,
            "reports": reports, "targetArtifactLevel": 0, "targetGroupNum": 1,
            "virtualId": long_id(b.id), "virtualName": b.name, "win": won}


@route(29, 3)  # GET_RANK_LIST
def pvp_rank_list(ctx: Context, req: dict):
    pvp = _pvp(ctx)
    rows = []
    for rank in range(1, int(ctx.config.value("PVP:RANK_LIST_SIZE", 5)) + 1):
        if rank == int(pvp["rank"]):
            rows.append({"artifactLevel": 0, "battleScore": my_power(ctx), "cultivateVo": None,
                         "desId": 0, "id": long_id(ctx.player_id), "leaderBaseId": int(ctx.cards[0]["base_id"]),
                         "leaderEquip": [], "leaderLevel": int(ctx.cards[0].get("level", 1)),
                         "leaderTalisman": [], "level": ctx.level, "name": ctx.record.role_name,
                         "rank": rank, "userBuffs": [], "vip": False})
            continue
        b = _pvp_bot(ctx, rank)
        rows.append({"artifactLevel": 0, "battleScore": b.power(ctx.config), "cultivateVo": None,
                     "desId": 0, "id": long_id(b.id), "leaderBaseId": b.leader, "leaderEquip": [],
                     "leaderLevel": b.level, "leaderTalisman": [], "level": b.level,
                     "name": b.name, "rank": rank, "userBuffs": [], "vip": False})
    return rows


@route(29, 4)  # LINEUP_COMPARE {id}
def pvp_compare(ctx: Context, req: dict):
    b = bot(ctx.config, as_id(req.get("id")))
    return {"enemy": _lineup(ctx, b.name, b.level, [(base, lv) for _, base, lv in b.cards]),
            "own": _own_lineup(ctx)}


@route(29, 5)  # CLEAR_COOL_DOWN
def pvp_clear(ctx: Context, req: dict):
    pvp = _pvp(ctx)
    ledger = ctx.ledger()
    if int(pvp["cool"]) > now_ms():
        minutes = max(1, (int(pvp["cool"]) - now_ms()) // 60_000)
        ledger.pay_jade(int(ctx.config.value("PVP:COOL_DOWN_COST", 5)) * int(minutes),
                        ctx.config.value("PVP:COOL_DOWN_COST_TYPE"))
        pvp["cool"] = 0
        ctx.save()
    return ledger.costs
