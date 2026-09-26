"""MsgBattle (mod 22): campaign battles, sweep, daily counts, records.

Flow used by the client: MULTI_ACTION (all waves at once) or ENTER + TRIGGER
per wave, then EXIT to settle.  QUICK_BATTLE / QUICK_ADVANCE settle at once.
Rewards (推测值 — the server-only formulas are unknown):
  copper = 100 + level * 50 per battle, exp = level * 10,
  BattleInfoConfig.itemDrop: always on first clear, 30% afterwards.
Stamina (BattleInfoConfig.cost) is only charged for a won battle.
"""

from __future__ import annotations

import random
import time

from ..combat import BOSS, MAJOR, MINOR, enemy_roster, fight, make_fighter
from ..defaults import long_id
from ..game import Context, GameError, as_id, embattle_ids, now_ms, parse_json, route
from ..gift import grant_hero

EMBATTLE_ERROR = -1
BATTLE_NOT_FOUND = -2
BATTLE_NOT_ENTER = -4
BLOCK_BY_PROGRESS = -10
ENTER_NOT_ENOUGH = -11
POINT_NOT_ENOUGH = -12
BLOCK_BY_LEVEL = -17
HERO_PACK_FULL = -18
DROP_RATE = 0.3  # 推测值


def _battle(ctx: Context, battle_id: str) -> dict:
    battle = ctx.config.battles.get(str(battle_id))
    if battle is None:
        raise GameError(BATTLE_NOT_FOUND, f"battle {battle_id}")
    return battle


def _today() -> str:
    return time.strftime("%Y%m%d")


def daily_counts(ctx: Context) -> dict:
    counts = ctx.state.setdefault("daily_counts", {})
    if ctx.state.get("daily_day") != _today():
        counts.clear()
        ctx.state["daily_day"] = _today()
        ctx.save()
    return counts


def _unlocked(ctx: Context, battle: dict) -> bool:
    cleared = set(ctx.state.get("battles", []))
    if battle["id"] in cleared:
        return True
    prev = battle.get("prevId")
    if prev:
        return prev in cleared
    same = sorted((b for b in ctx.config.rows("BattleInfoConfig")
                   if b["campaignId"] == battle["campaignId"]), key=lambda b: int(b["sort"]))
    index = next(i for i, b in enumerate(same) if b["id"] == battle["id"])
    if index > 0:
        return same[index - 1]["id"] in cleared
    campaign = ctx.config.index("CampaignConfig").get(battle["campaignId"], {})
    prev_campaign = campaign.get("prevId")
    if not prev_campaign:
        return True
    return prev_campaign in set(ctx.state.get("campaigns", []))


def _check_enter(ctx: Context, battle: dict) -> None:
    if ctx.level < int(battle.get("level") or 1):
        raise GameError(BLOCK_BY_LEVEL, "level")
    if not _unlocked(ctx, battle):
        raise GameError(BLOCK_BY_PROGRESS, "previous battle not cleared")
    limit = int(battle.get("dailyCount") or 0)
    if limit and int(daily_counts(ctx).get(battle["id"], 0)) >= limit:
        raise GameError(ENTER_NOT_ENOUGH, "daily count")
    from ..game import refresh_points
    if int(refresh_points(ctx).get("0", 0)) < int(battle.get("cost") or 0):
        raise GameError(POINT_NOT_ENOUGH, "stamina")


def _attackers(ctx: Context, grid: list[list[int]]) -> list:
    group = next(g for g in ctx.groups["groups"] if int(g["groupId"]) == int(ctx.groups["curGroupId"]))
    leader = int(group["leaderId"])
    fighters = []
    for row_index, row in enumerate(grid):
        for col_index, card_id in enumerate(row):
            if not card_id:
                continue
            card = ctx.card(card_id)
            if card is None:
                raise GameError(EMBATTLE_ERROR, "card not owned")
            fighters.append(make_fighter(
                ctx.config, row_index * 2 + col_index, int(card["base_id"]),
                int(card.get("level", 1)), MAJOR if card_id == leader else MINOR,
                int(card.get("power_skill") or 0), card_id=card_id))
    if not fighters:
        raise GameError(EMBATTLE_ERROR, "empty formation")
    return fighters


def _defenders(ctx: Context, battle: dict, wave: int, waves: int) -> list:
    level = max(1, int(battle.get("level") or 1))
    # BATTLE:BLOCK_SECTIONS (序章 CN01/CN02) are the scripted guide chapters:
    # one weak enemy per wave so the tutorial can always be completed.
    guided = battle["id"][:4] in ctx.config.value("BATTLE:BLOCK_SECTIONS", [])
    scale = 0.4  # 推测值: tuned so an at-level starter team clears early chapters
    count = 1 if guided else (3 if wave == waves - 1 else 2)
    fighters = []
    for slot, base_id, role in enemy_roster(ctx.config, battle["id"], wave, waves, count=count):
        fighters.append(make_fighter(ctx.config, slot, base_id, level, role,
                                     scale=scale * (1.8 if role == BOSS else 1.0)))
    return fighters


def simulate(ctx: Context, battle_id: str, grid: list[list[int]]) -> list[dict]:
    """Run every wave; attackers keep their HP between waves."""
    battle = _battle(ctx, battle_id)
    waves = max(1, int(battle.get("enemies") or 1))
    attackers = _attackers(ctx, grid)
    rng = random.Random()
    level = max(1, int(battle.get("level") or 1))
    coins_total = 100 + level * 50
    triggers = []
    for wave in range(waves):
        alive = [u for u in attackers if u.alive]
        defenders = _defenders(ctx, battle, wave, waves)
        won, report = fight(ctx.config, alive, defenders, rng)
        per_wave = coins_total // waves + (1 if wave < coins_total % waves else 0)
        triggers.append({
            "coins": per_wave if won else 0,
            "drops": [[] for _ in defenders],
            "finished": wave == waves - 1 or not won,
            "index": wave,
            "reports": report,
            "success": won,
        })
        if not won:
            break
    return triggers


def _pending(ctx: Context, battle_id: str, triggers: list[dict], friend: int = 0) -> None:
    battle = _battle(ctx, battle_id)
    success = all(t["success"] for t in triggers) and len(triggers) == max(1, int(battle.get("enemies") or 1))
    ctx.state["pending_battle"] = {
        "battle_id": battle_id, "success": success,
        "coins": sum(int(t["coins"]) for t in triggers),
        "exp": max(1, int(battle.get("level") or 1)) * 10,
        "cost": int(battle.get("cost") or 0), "waves": len(triggers),
        "total": max(1, int(battle.get("enemies") or 1)), "friend": friend,
        "rounds": 0,
    }
    ctx.save()


@route(22, 9)  # MULTI_ACTION: fight every wave at once
def multi_action(ctx: Context, req: dict):
    battle_id = str(req.get("battleId") or "")
    battle = _battle(ctx, battle_id)
    _check_enter(ctx, battle)
    triggers = simulate(ctx, battle_id, embattle_ids(req.get("embattle")))
    _pending(ctx, battle_id, triggers, as_id(req.get("friend")))
    ctx.state["pending_triggers"] = []
    return triggers


@route(22, 2)  # ENTER: wave-by-wave mode
def enter(ctx: Context, req: dict):
    battle_id = str(req.get("battleId") or "")
    battle = _battle(ctx, battle_id)
    _check_enter(ctx, battle)
    triggers = simulate(ctx, battle_id, embattle_ids(req.get("embattle")))
    _pending(ctx, battle_id, triggers, as_id(req.get("friend")))
    # reports are bytes; keep them hex-encoded in the JSON save
    ctx.state["pending_triggers"] = [dict(t, reports=t["reports"].hex()) for t in triggers]
    total = max(1, int(battle.get("enemies") or 1))
    return {"battleId": battle_id, "remains": total, "totalEnemies": total}


@route(22, 4)  # TRIGGER: next wave of an ENTERed battle
def trigger(ctx: Context, req: dict):
    queue = ctx.state.get("pending_triggers") or []
    if not queue:
        raise GameError(BATTLE_NOT_ENTER, "no wave pending")
    wave = queue.pop(0)
    ctx.save()
    return dict(wave, reports=bytes.fromhex(wave["reports"]))


def resume_vo(ctx: Context) -> dict | None:
    pending = ctx.state.get("pending_battle")
    if not pending:
        return None
    queue = ctx.state.get("pending_triggers") or []
    return {"assistant": None, "battleId": pending["battle_id"], "coins": int(pending["coins"]),
            "equips": 0, "failed": not pending["success"], "finished": not queue,
            "fragments": 0, "heros": 0, "remains": len(queue),
            "totalEnemies": int(pending["total"])}


@route(22, 3)  # RESUME
def resume(ctx: Context, req: dict):
    return resume_vo(ctx)


def settle(ctx: Context) -> dict:
    """Apply the pending battle's result and return ExitVo."""
    pending = ctx.state.pop("pending_battle", None)
    ctx.state.pop("pending_triggers", None)
    ledger = ctx.ledger()
    failed = int(ctx.state.get("failed_times", 0))
    if not pending:
        return {"costAndReward": ledger.cost_and_reward(), "failedTimes": failed, "hasDemog": False}
    battle = _battle(ctx, pending["battle_id"])
    if not pending["success"]:
        ctx.state["failed_times"] = failed + 1
        ctx.save()
        return {"costAndReward": ledger.cost_and_reward(), "failedTimes": failed + 1,
                "hasDemog": False}
    battle_id = battle["id"]
    first_clear = battle_id not in ctx.state.setdefault("battles", [])
    if first_clear:
        ctx.state["battles"].append(battle_id)
        _clear_campaign(ctx, battle)
    counts = daily_counts(ctx)
    counts[battle_id] = int(counts.get(battle_id, 0)) + 1
    ledger.pay_action_point(int(pending["cost"]))
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": int(pending["coins"])})
    ledger.grant({"type": "EXP", "code": 0, "amount": int(pending["exp"])})
    for spec in parse_json(battle.get("itemDrop"), []):
        if first_clear or random.random() < DROP_RATE:
            ledger.grant(spec)
    if int(pending.get("friend") or 0) > 0:  # -1 = no assistant
        ledger.grant({"type": "CURRENCY", "code": 5,
                      "amount": int(ctx.config.value("BATTLE:PARTNER_FRIENDSHIP", 10))})
    if battle_id == "CN01BN01" and first_clear:
        # 推测值: the guide's first-drop cards (five 小萌牛) that the upgrade
        # tutorial consumes; verified to drive the stock guide on device.
        for _ in range(5):
            ledger.rewards.append(grant_hero(ctx.schema, ctx.record, ctx.state, 71, ctx.config))
    ctx.state["failed_times"] = 0
    ctx.save()
    return {"costAndReward": ledger.cost_and_reward(), "failedTimes": 0, "hasDemog": False}


def _clear_campaign(ctx: Context, battle: dict) -> None:
    same = [b for b in ctx.config.rows("BattleInfoConfig") if b["campaignId"] == battle["campaignId"]]
    cleared = set(ctx.state["battles"])
    campaigns = ctx.state.setdefault("campaigns", [])
    if all(b["id"] in cleared for b in same) and battle["campaignId"] not in campaigns:
        campaigns.append(battle["campaignId"])


@route(22, 5)  # EXIT
def exit_battle(ctx: Context, req: dict):
    return settle(ctx)


def _quick(ctx: Context, battle_id: str, grid: list[list[int]], friend: int) -> dict:
    battle = _battle(ctx, battle_id)
    _check_enter(ctx, battle)
    triggers = simulate(ctx, battle_id, grid)
    _pending(ctx, battle_id, triggers, friend)
    success = ctx.state["pending_battle"]["success"]
    exit_vo = settle(ctx)
    return {"assistant": None, "battleId": battle_id, "exitVo": exit_vo,
            "failed": not success, "finished": True}


@route(22, 8)  # QUICK_BATTLE (skip animation)
def quick_battle(ctx: Context, req: dict):
    return _quick(ctx, str(req.get("battleId") or ""), embattle_ids(req.get("embattle")),
                  as_id(req.get("friend")))


@route(22, 10)  # QUICK_ADVANCE (扫荡: only cleared battles, current formation)
def quick_advance(ctx: Context, req: dict):
    battle_id = str(req.get("battleId") or "")
    if battle_id not in ctx.state.get("battles", []):
        raise GameError(BLOCK_BY_PROGRESS, "sweep needs a cleared battle")
    group = next(g for g in ctx.groups["groups"] if int(g["groupId"]) == int(ctx.groups["curGroupId"]))
    return _quick(ctx, battle_id, group["embattles"], as_id(req.get("friend")))


@route(22, 1)  # PROGRESS
def progress(ctx: Context, req: dict):
    return {"battles": list(ctx.state.get("battles", [])),
            "campaigns": list(ctx.state.get("campaigns", [])),
            "current": resume_vo(ctx), "dailyCounts": dict(daily_counts(ctx))}


@route(22, 7)  # DAILYCOUNT
def dailycount(ctx: Context, req: dict):
    return dict(daily_counts(ctx))


@route(22, 6)  # ACTIVES: activity campaigns — all kept open locally
def actives(ctx: Context, req: dict):
    now = now_ms()
    ids = sorted({b["campaignId"] for b in ctx.config.rows("BattleInfoConfig")
                  if not b["campaignId"].startswith("CN")})
    return {"activeCounts": {},
            "actives": [{"id": cid, "startTime": now - 86_400_000, "stopTime": now + 365 * 86_400_000}
                        for cid in ids]}


def _record(ctx: Context) -> list[dict]:
    return []


@route(22, 11)  # FIRST_RECORD (server-wide first clears; single player: none)
def first_record(ctx: Context, req: dict):
    return _record(ctx)


@route(22, 12)  # BEST_RECORD
def best_record(ctx: Context, req: dict):
    return _record(ctx)
