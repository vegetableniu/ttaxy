"""Smaller systems: 龙宫寻宝 (14), 成就徽章 (23), 锁妖塔/转生 (27), SMS (44),
Tencent wallet query (68), offline tips (40)."""

from __future__ import annotations

import random

from ..game import Context, GameError, as_id, charge_times, parse_json, route

# ------------------------------------------------------------ 龙宫寻宝 (14)
ADVANCE_ODDS = [0.7, 0.55, 0.4, 0.25, 0.0]  # 推测值


def _treasure(ctx: Context) -> dict:
    return ctx.state.setdefault("treasure", {"rank": 0, "treasures": []})


def _treasure_pool(ctx: Context, rank: int) -> list[int]:
    cards = [h for h in ctx.config.rows("BaseHero") if "龙宫寻宝" in h["gain"]
             and not h["name"].startswith("测试")]
    good = [int(h["id"]) for h in cards if int(h["star"]) >= 2 + rank]
    return good or [int(h["id"]) for h in cards] or [200]


def _look(ctx: Context) -> dict:
    t = _treasure(ctx)
    if len(t["treasures"]) >= int(ctx.config.value("TREASURE:PACK_SIZE", 8)):
        raise GameError(-1, "treasure pack full")
    rank = int(t["rank"])
    ledger = ctx.ledger()
    ledger.pay_currency("COPPER", int(ctx.config.index("RankConfig").get(rank, {}).get("costs") or 0))
    found = random.choice(_treasure_pool(ctx, rank))
    t["treasures"].append(found)
    t["rank"] = min(rank + 1, 4) if random.random() < ADVANCE_ODDS[rank] else 0
    ctx.save()
    return {"costs": list(ledger.costs), "rank": int(t["rank"]), "treasures": [found]}


@route(14, 1)  # INFO
def treasure_info(ctx: Context, req: dict):
    t = _treasure(ctx)
    return {"rank": int(t["rank"]), "treasures": list(t["treasures"])}


@route(14, 2)  # LOOKFOR
def treasure_look(ctx: Context, req: dict):
    return _look(ctx)


@route(14, 3)  # AUTO_LOOKFOR (VIP perk)
def treasure_auto(ctx: Context, req: dict):
    from .player import vip_info
    if not vip_info(ctx)["vip"] and charge_times(ctx, "AUTO_TREASURE", 0) <= 0:
        raise GameError(-3, "vip only")
    results = []
    while len(_treasure(ctx)["treasures"]) < int(ctx.config.value("TREASURE:PACK_SIZE", 8)):
        try:
            results.append(_look(ctx))
        except GameError:
            break
    return results


@route(14, 4)  # RECEIVE
def treasure_receive(ctx: Context, req: dict):
    t = _treasure(ctx)
    if not t["treasures"]:
        raise GameError(-2, "empty")
    from .hero import pack_limit
    ledger = ctx.ledger()
    sold = 0
    for base in t["treasures"]:
        if len(ctx.cards) >= pack_limit(ctx):
            info = ctx.config.heroes.get(base, {})
            ledger.grant({"type": "CURRENCY", "code": 0, "amount": int(info.get("baseCoins") or 0)})
            sold += 1
        else:
            ledger.grant({"type": "HERO", "code": base, "amount": 1})
    t["treasures"] = []
    ctx.save()
    return {"rewards": ledger.rewards, "solds": sold}


# -------------------------------------------------------- 成就徽章 (23)
def _achieved(ctx: Context) -> list[int]:
    skills = ctx.config.index("SkillConfig")
    done = []
    for row in ctx.config.rows("AchieveConfig"):
        cards = [c for c in ctx.cards if int(c["base_id"]) == int(row["cardId"])]
        kind, value = row["reachType"], int(row["value"])
        if kind == "AMOUNT":
            ok = len(cards) >= value
        elif kind == "LEVEL":
            ok = any(int(c.get("level", 1)) >= value for c in cards)
        else:  # SKILL_LEVEL
            ok = any(int(skills.get(int(c.get("power_skill") or 0), {}).get("level") or 0) >= value
                     for c in cards)
        if ok:
            done.append(int(row["id"]))
    return done


@route(23, 1)  # COMMOND_GET_ACHIEVE_LIST
def achieve_list(ctx: Context, req: dict):
    return _achieved(ctx)


def _emblem(ctx: Context) -> dict:
    return ctx.state.setdefault("emblem", {"drawn": [], "chapters": []})


@route(23, 3)  # COMMOND_DRAW {chapterId, id}
def achieve_draw(ctx: Context, req: dict):
    row = ctx.config.index("AchieveConfig").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-2, "no achievement")
    emblem = _emblem(ctx)
    if row["id"] in emblem["drawn"] or row["id"] not in _achieved(ctx):
        raise GameError(-3, "cannot draw")
    ledger = ctx.ledger()
    ledger.grant_reward_id(row["rewardId"])
    emblem["drawn"].append(row["id"])
    ctx.save()
    return {"rewardResult": ledger.rewards, "status": 1}


@route(23, 2)  # COMMOND_DRAW_CHAPTER {id}
def achieve_chapter(ctx: Context, req: dict):
    row = ctx.config.index("ChapterAchieveConfig").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-1, "no chapter")
    emblem = _emblem(ctx)
    done = [a for a in ctx.config.rows("AchieveConfig")
            if int(a["chapterId"]) == int(row["id"]) and a["id"] in _achieved(ctx)]
    if row["id"] in emblem["chapters"] or len(done) < int(row["reachNum"]):
        raise GameError(-3, "cannot draw")
    ledger = ctx.ledger()
    ledger.grant_reward_id(row["rewardId"])
    emblem["chapters"].append(row["id"])
    ctx.save()
    return {"rewardResult": ledger.rewards, "status": 1}


# ------------------------------------------------------ 锁妖塔 (27 rebirth)
def _rebirth(ctx: Context) -> dict:
    from .battle import _today
    r = ctx.state.setdefault("rebirth", {"battles": [], "counts": {}, "buys": {}, "day": ""})
    if r["day"] != _today():
        r.update(counts={}, buys={}, day=_today())
    return r


def _rebirth_battle(ctx: Context, battle_id) -> dict:
    battle = ctx.config.battles.get(str(battle_id))
    if battle is None or not str(battle_id).startswith("CL"):
        raise GameError(-2, "battle not found")
    return battle


def _rebirth_fight(ctx: Context, battle: dict, groups) -> tuple[bool, list, dict]:
    from .elite import _fight
    r = _rebirth(ctx)
    limit = int(battle.get("dailyCount") or 0) + int(r["buys"].get(battle["id"], 0))
    if limit and int(r["counts"].get(battle["id"], 0)) >= limit:
        raise GameError(-11, "no entries")
    if ctx.level < int(battle.get("level") or 1):
        raise GameError(-17, "level")
    prev = battle.get("prevId")
    if prev and prev not in r["battles"]:
        raise GameError(-10, "previous floor")
    won, triggers = _fight(ctx, battle, groups)
    ledger = ctx.ledger()
    if won:
        if battle["id"] not in r["battles"]:
            r["battles"].append(battle["id"])
        r["counts"][battle["id"]] = int(r["counts"].get(battle["id"], 0)) + 1
        level = int(battle.get("level") or 1)
        ledger.pay_action_point(int(battle.get("cost") or 0))
        ledger.grant({"type": "CURRENCY", "code": 0, "amount": 300 + level * 100})  # 推测值
        ledger.grant({"type": "EXP", "code": 0, "amount": level * 20})               # 推测值
        ledger.grant_all(parse_json(battle.get("itemDrop"), []))
        ctx.save()
    return won, triggers, ledger.cost_and_reward()


def _rebirth_vo(battle: dict, won: bool, triggers: list, reward: dict) -> dict:
    return {"battleId": battle["id"], "costAndReward": reward, "finished": True,
            "groupNum": len(triggers), "hasDemog": False, "triggers": triggers}


@route(27, 1)  # PROGRESS {campaignId}
def rebirth_progress(ctx: Context, req: dict):
    r = _rebirth(ctx)
    return {"activeBuys": dict(r["buys"]), "activeCounts": dict(r["counts"]),
            "battles": list(r["battles"]), "buyCount": sum(r["buys"].values())}


def _groups(req: dict) -> list:
    return [[[as_id(v) for v in row] for row in grid] for grid in req.get("embattle") or []]


@route(27, 2)  # MULTI_ACTION
def rebirth_attack(ctx: Context, req: dict):
    battle = _rebirth_battle(ctx, req.get("battleId"))
    won, triggers, reward = _rebirth_fight(ctx, battle, _groups(req))
    return _rebirth_vo(battle, won, triggers, reward)


@route(27, 5)  # QUICK_BATTLE
def rebirth_quick(ctx: Context, req: dict):
    return rebirth_attack(ctx, req)


@route(27, 6)  # QUICK_ADVANCE (sweep a cleared floor)
def rebirth_sweep(ctx: Context, req: dict):
    battle = _rebirth_battle(ctx, req.get("battleId"))
    if battle["id"] not in _rebirth(ctx)["battles"]:
        raise GameError(-10, "not cleared")
    group = ctx.groups["groups"][0]["embattles"]
    won, triggers, reward = _rebirth_fight(ctx, battle, [group])
    return _rebirth_vo(battle, won, triggers, reward)


@route(27, 7)  # QUICK_CAMPAIGN {campaignId}: sweep every cleared floor of a tower
def rebirth_sweep_campaign(ctx: Context, req: dict):
    cid = str(req.get("campaignId") or "")
    total = {"costs": [], "rewards": []}
    for battle in ctx.config.rows("BattleInfoConfig"):
        if battle["campaignId"] == cid and battle["id"] in _rebirth(ctx)["battles"]:
            try:
                _, _, reward = _rebirth_fight(ctx, battle, [ctx.groups["groups"][0]["embattles"]])
            except GameError:
                continue
    ledger = ctx.ledger()
    return ledger.cost_and_reward()


@route(27, 3)  # BUY_TIMES {battleId}
def rebirth_buy(ctx: Context, req: dict):
    battle = _rebirth_battle(ctx, req.get("battleId"))
    r = _rebirth(ctx)
    costs = ctx.config.value("REBIRTH:BUY_COST", [10])
    bought = sum(int(v) for v in r["buys"].values())
    if bought >= len(costs) or bought >= charge_times(ctx, "REBIRTH_BUYS", len(costs)):
        raise GameError(-13, "buy limit")
    ledger = ctx.ledger()
    ledger.pay_jade(int(costs[bought]), ctx.config.value("REBIRTH:BUY_TYPE"))
    r["buys"][battle["id"]] = int(r["buys"].get(battle["id"], 0)) + 1
    ctx.save()
    limit = int(battle.get("dailyCount") or 0) + int(r["buys"][battle["id"]])
    return {"costResults": ledger.costs, "hasBuyTimes": int(r["buys"][battle["id"]]),
            "times": limit - int(r["counts"].get(battle["id"], 0))}


@route(27, 4)  # RECORD
def rebirth_record(ctx: Context, req: dict):
    return []


# ---------------------------------------------------------------- SMS (44)
@route(44, 1)  # SEND {phone}: 单机 — no SMS; any code is accepted by VERIFY
def sms_send(ctx: Context, req: dict):
    ctx.state["sms_phone"] = str(req.get("phone") or "")
    ctx.save()
    return 0


@route(44, 2)  # VERIFY {content}: SMS:CONFIRM_REWARD once
def sms_verify(ctx: Context, req: dict):
    if ctx.state.get("sms_verified"):
        raise GameError(-1, "already verified")
    if ctx.level < int(ctx.config.value("SMS:LEVEL_LIMIT", 0)):
        raise GameError(-2, "level")
    ledger = ctx.ledger()
    ledger.grant_all(ctx.config.value("SMS:CONFIRM_REWARD", []))
    ctx.state["sms_verified"] = True
    ctx.save()
    return ledger.rewards


# ------------------------------------------------------------- misc (40/68)
@route(40, 1)  # GET_OFFLINE tips
def offline_tips(ctx: Context, req: dict):
    return []


@route(68, 1)  # UPLOAD_API_ARGS
def tencent_upload(ctx: Context, req: dict):
    return 0


@route(68, 2)  # QUERY_BALANCE
def tencent_balance(ctx: Context, req: dict):
    from .player import wallet
    return wallet(ctx, req)
