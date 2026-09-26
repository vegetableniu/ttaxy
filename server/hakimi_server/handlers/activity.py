"""Activities, all kept open in the local build (server_settings.json
"activities": open_all / disabled / extra entries).

GET_ACTIVITYS lists every activity type the client knows (Logic/Gift,
UI/GiftActivityItem); each module below implements its own commands with the
client's config tables.  Amounts the original server kept private are 推测值.
"""

from __future__ import annotations

import random
import time

from ..bots import BOT_BASE, bot
from ..defaults import long_id
from ..game import Context, GameError, as_id, now_ms, parse_json, route
from ..settings import setting
from .player import show_spec

YEAR = 365 * 86_400_000

# (activityType, id, name, lockKey, mallId)  — ids match the client tables
ACTIVITIES = [
    ("ACTIVITY_CHARGE", "ACTIVITY_CHARGE_1", "充值活动", "ACTIVITY_CHARGE_1", 0),
    ("GROUP_BUY", "GROUP_BUY", "团购", "", 0),
    ("CHARGE_RETURN", "CHARGE_RETURN", "累充返还", "", 0),
    ("DEPOSIT_START", "DEPOSIT", "理财计划", "", 0),
    ("RED_CARD_EXCHANGE", "RedCardExchange_1", "红卡兑换", "RED_CARD_COMPOSE", 0),
    ("TOKEN_COIN", "TOKEN_COIN", "代币商城", "", 410),
    ("VIP_MONTH", "VIP_MONTH", "月卡", "", 0), ("VIP_WEEK", "VIP_WEEK", "周卡", "", 0),
    ("DUMPLING", "DUMPLING", "包饺子", "", 0), ("SMASH_EGG", "SMASH_EGG", "砸金蛋", "", 0),
    ("OPEN_BOX", "OPEN_BOX", "开宝箱", "", 0), ("TREASURE_ROOM", "TREASURE_ROOM", "宝阁", "", 0),
    ("SECRETSHOP", "SECRETSHOP", "神秘商店", "SECRETSHOP", 0), ("GEM_ROOM", "GEM_ROOM", "宝石屋", "", 0),
    ("EXCHANGE_SHOP", "EXCHANGE_SHOP", "兑换商店", "", 0), ("RAFFLE", "RAFFLE", "翻牌抽奖", "", 0),
    ("FOOLSDAY", "FOOLSDAY", "愚人节翻牌", "", 0), ("QINGMING", "QINGMING", "清明祭拜", "", 0),
    ("QINGMING_RANK", "QING_MING_RANK", "清明排行", "", 0), ("JUHUASUAN", "JUHUASUAN", "聚划算", "", 0),
    ("EQUIP_GIFT", "EQUIP_GIFT", "装备折扣礼包", "EQUIP_GIFT", 0),
    ("EQUIP_MATERIAL", "EQUIP_MATERIAL", "紫封石折扣礼包", "EQUIP_MATERIAL", 0),
    ("FOOTBALL", "FOOTBALL", "足球射门", "", 0), ("BLESSING", "BLESSING", "祈福", "", 0),
    ("GOD_REWARD", "GOD_REWARD", "天神悬赏", "", 0), ("MOON", "MOON", "中秋博饼", "", 0),
    ("MONOPOLY", "MONOPOLY", "大富翁", "", 0), ("NEW_MONOPOLY", "valentine", "情人节大富翁", "", 0),
    ("SLOT", "SLOT", "老虎机", "", 0), ("SWEET_HOUSE", "SWEET_HOUSE", "糖果屋", "", 0),
    ("TURKEY", "TURKEY", "感恩节火鸡", "", 0), ("RECYCLE", "RECYCLE", "熔炼", "RecyclePool1", 0),
    ("EXPLORE", "EXPLORE", "探索", "", 0), ("CHRISTMAS", "CHRISTMAS", "圣诞任务", "", 0),
    ("CONSUME_RANK", "New_Consume_Rank", "消费排行", "", 0),
    ("NEW_CONSUME_RANK", "New_Consume_Rank16", "消费积分排行", "", 0),
    ("CHARGE", "Charge_Rank_Activity1", "充值排行", "", 0),
    ("ARTIFACT_UPGRADE", "ArtifactUpgrade1", "神器升阶奖励", "", 0),
    ("ARTIFACT_RANK", "ARTIFACT_RANK", "神器排行", "", 0),
    ("HERO_RANK_UP", "HERO_RANK_UP", "升星奖励", "", 0),
    ("EXCHANGE", "EXCHANGE_1", "糖果兑换", "", 0), ("FAKE_GROUP_BUY", "FAKE_GROUP_BUY", "限时团购", "", 0),
    ("SPRING", "SPRING", "春节活动", "", 0),
]


def _today() -> str:
    return time.strftime("%Y%m%d")


@route(16, 9)  # GET_ACTIVITYS: everything open for a year from now
def get_activitys(ctx: Context, req: dict):
    disabled = set(setting("activities.disabled", []) or [])
    rows = list(ACTIVITIES) + [tuple(x) for x in setting("activities.extra", []) or []]
    now = now_ms()
    activities = []
    if setting("activities.open_all", True):
        for kind, aid, name, lock, mall in rows:
            if aid in disabled or kind in disabled:
                continue
            activities.append({"activityType": kind, "desc": name, "endTime": now + YEAR, "gifts": [],
                               "icon": None, "id": aid, "level": 1, "lockKey": lock, "mallId": mall,
                               "name": name, "show": True, "showTemplete": kind,
                               "startTime": now - 86_400_000})
    return {"activitys": activities, "logs": {}}


def draw_global_gift(ctx: Context, gift_id: str):
    raise GameError(-1, "gift not found")


# ------------------------------------------------------------- 50 dumpling
@route(50, 1)
def dumpling_cool(ctx, req):
    d = ctx.state.get("dumpling", {})
    return {"baseId": int(d.get("base", 0)), "coolTime": int(d.get("cool", 0))}


@route(50, 2)
def dumpling_state(ctx, req):
    return None


@route(50, 3)  # COOK {dumpling}: DumplingSetting by baseId
def dumpling_cook(ctx, req):
    base = as_id(req.get("dumpling"))
    row = next((r for r in ctx.config.rows("DumplingSetting") if int(r["baseId"]) == base or int(r["id"]) == base), None)
    if row is None:
        raise GameError(-1, "no dumpling")
    d = ctx.state.setdefault("dumpling", {})
    if int(d.get("cool", 0)) > now_ms():
        raise GameError(-2, "cooking")
    d.update(base=int(row["baseId"]), row=int(row["id"]), cool=now_ms() + int(row["coolTime"]) * 60_000)
    ctx.save()
    return {"coolTime": d["cool"], "costs": [], "type": int(row["id"])}


@route(50, 4)
def dumpling_reward(ctx, req):
    d = ctx.state.get("dumpling") or {}
    if not d.get("row") or int(d.get("cool", 0)) > now_ms():
        raise GameError(-3, "not ready")
    row = ctx.config.index("DumplingSetting").get(int(d["row"]), {})
    led = ctx.ledger()
    for rid in parse_json(row.get("reward"), []):
        led.grant_reward_id(rid)
    ctx.state["dumpling"] = {}
    ctx.save()
    return led.rewards


@route(50, 5)
def dumpling_clear(ctx, req):
    d = ctx.state.get("dumpling") or {}
    led = ctx.ledger()
    left = max(0, int(d.get("cool", 0)) - now_ms()) // 60_000
    if left:
        led.pay_jade(max(1, int(left * float(ctx.config.value("DUMPLING:COOLTIME_COST_COUNT", 0.5)))))
        d["cool"] = 0
        ctx.save()
    return led.costs


# ----------------------------------------------------------- 51 fakegroupbuy
@route(51, 1)
def fgb_info(ctx, req):
    rec = ctx.state.get("fakegroupbuy", {})
    return [{"drawed": list(v), "id": int(k)} for k, v in rec.items()]


@route(51, 2)  # BUY_GOODS {id}: GroupSetting goods
def fgb_buy(ctx, req):
    row = ctx.config.index("GroupSetting").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-1, "goods")
    led = ctx.ledger()
    led.pay_jade(int(row["now"]), parse_json(row.get("costTypes"), None))
    led.grant_reward_id(row["goods"])
    ctx.state.setdefault("fakegroupbuy", {}).setdefault(str(row["id"]), [])
    ctx.save()
    return {"costs": led.costs, "id": int(row["id"]), "rewards": led.rewards}


@route(51, 3)  # DRAW_REWARD {id, types}: buyer-count tiers (bots fill every tier)
def fgb_draw(ctx, req):
    row = ctx.config.index("GroupSetting").get(int(req.get("id") or 0))
    rec = ctx.state.setdefault("fakegroupbuy", {}).get(str(req.get("id") or 0))
    if row is None or rec is None:
        raise GameError(-2, "buy first")
    tiers = parse_json(row.get("rewards"), {})
    led = ctx.ledger()
    for t in req.get("types") or []:
        key = next((k for i, k in enumerate(tiers) if i == int(t)), None)
        if key is None or int(t) in rec:
            continue
        led.grant_reward_id(tiers[key])
        rec.append(int(t))
    ctx.save()
    return led.rewards


# ------------------------------------------------------------------ 52 egg
def _egg(ctx) -> dict:
    e = ctx.state.setdefault("egg", {"day": "", "free": 0, "cost": 0, "hammer": 0, "today": 0, "log": []})
    if e["day"] != _today():
        e.update(day=_today(), free=0, today=0)
    return e


def _egg_vo(ctx) -> dict:
    e = _egg(ctx)
    return {"costSmashCount": e["cost"], "eggRewardVos": e["log"][-10:],
            "freeSmashCount": max(0, int(ctx.config.value("SMASH_EGG:INIT_FREE_TIMES", 1)) - e["free"]),
            "hammer": ctx.counter("reward_EGG_HAMMER_0"), "hammerSmashCount": e["hammer"],
            "todaySmash": e["today"], "topRewardVo": None,
            "totalCurrency": int(ctx.config.value("SMASH_EGG:INIT_CURRENCY", 5000))}


@route(52, 1)
def egg_info(ctx, req):
    return _egg_vo(ctx)


@route(52, 2)  # SMASH {smashId}
def egg_smash(ctx, req):
    e = _egg(ctx)
    led = ctx.ledger()
    free_left = int(ctx.config.value("SMASH_EGG:INIT_FREE_TIMES", 1)) - e["free"]
    if free_left > 0:
        kind, e["free"] = 2, e["free"] + 1
    elif ctx.counter("reward_EGG_HAMMER_0") > 0:
        kind = 0
        ctx.add_counter("reward_EGG_HAMMER_0", -1)
        e["hammer"] += 1
    else:
        kind = 1
        led.pay_jade(50)  # 推测值
        e["cost"] += 1
    reward = random.choice([{"type": "CURRENCY", "code": 0, "amount": 20000},
                            {"type": "HERO", "code": 311, "amount": 1},
                            {"type": "CURRENCY", "code": 2, "amount": 20}])  # 推测值
    led.grant(reward)
    e["today"] += 1
    ctx.save()
    vo = _egg_vo(ctx)
    vo.update(costResult=led.costs, eachSmashVOs={int(req.get("smashId") or 0): {
        "rewardId": "", "rewardResults": list(led.rewards), "smashType": kind}})
    return vo


# ------------------------------------------------------------------ 54 box
@route(54, 3)
def box_info(ctx, req):
    keys = {i: ctx.counter(f"reward_BOX_KEY_{i}") for i in (1, 2, 3)}
    opened = ctx.state.get("box_cost_open", {})
    return {"coinNum": 0, "costOpenTimes": {int(k): int(v) for k, v in opened.items()}, "keys": keys}


def _box_reward(ctx, box_id: int, led) -> None:
    rows = [r for r in ctx.config.rows("RingBox") if int(r["id"]) == box_id] or ctx.config.rows("RingBox")
    row = rows[0]
    kinds, ids, amounts = (parse_json(row["showTypes"], [[]])[0], parse_json(row["showIds"], [[]])[0],
                           parse_json(row["amounts"], [[]])[0])
    i = random.randrange(len(kinds))
    kind = kinds[i] if kinds[i] != "GOLDCARD" else "GOLD"
    if kind == "MONOPOLY":
        led.grant({"type": "MONOPOLY", "code": 0, "amount": int(amounts[i])})
    else:
        led.grant(show_spec(kind, ids[i], amounts[i]))


@route(54, 1)  # OPEN_BOX_BY_KEY {boxId}
def box_open_key(ctx, req):
    box = int(req.get("boxId") or 1)
    if ctx.counter(f"reward_BOX_KEY_{box}") <= 0:
        raise GameError(-1, "no key")
    ctx.add_counter(f"reward_BOX_KEY_{box}", -1)
    led = ctx.ledger()
    _box_reward(ctx, box, led)
    return {"keys": {i: ctx.counter(f"reward_BOX_KEY_{i}") for i in (1, 2, 3)}, "rewardResults": led.rewards}


@route(54, 2)  # OPEN_BOX_BY_CURRENCY {boxId}
def box_open_cost(ctx, req):
    box = int(req.get("boxId") or 1)
    led = ctx.ledger()
    led.pay_jade(50 * box)  # 推测值
    _box_reward(ctx, box, led)
    opened = ctx.state.setdefault("box_cost_open", {})
    opened[str(box)] = int(opened.get(str(box), 0)) + 1
    ctx.save()
    return {"costOpenTimes": {int(k): int(v) for k, v in opened.items()}, "costResults": led.costs,
            "rewardResults": led.rewards}


# ------------------------------------------------- 55/59 consume & charge rank
def _rank_lists(ctx, my_score: int):
    top = []
    for rank in range(1, 6):
        b = bot(ctx.config, BOT_BASE + 600 + rank, 80 - rank)
        top.append({"id": long_id(b.id), "leaderBaseId": b.leader, "name": b.name,
                    "playerLevel": b.level, "rank": rank, "score": (6 - rank) * 5000})
    return top


def _rank_vo(ctx, score: int, drawn: list) -> dict:
    top = _rank_lists(ctx, score)
    rank = sum(1 for t in top if t["score"] > score) + 1
    return {"closeTime": now_ms() + YEAR, "drawedIds": list(drawn), "nearList": [], "rank": rank,
            "score": score, "topList": top, "topName": top[0]["name"], "topScore": top[0]["score"]}


@route(11, 17)  # GET_CONSUME_RANK
def player_consume_rank(ctx, req):
    return [{"consume": t["score"], "id": t["id"], "leaderBaseId": t["leaderBaseId"],
             "leaderLevel": t["playerLevel"], "name": t["name"], "rank": t["rank"]}
            for t in _rank_lists(ctx, ctx.counter("gold_consumed"))]


@route(55, 1)
def consume_info(ctx, req):
    return _rank_vo(ctx, ctx.counter("gold_consumed"), ctx.state.get("consume_drawn", []))


@route(55, 2)  # DRAW_SCORE_REWARD [id]: ScoreReward
def consume_draw(ctx, req):
    rid = int(req.get("_") or 0)
    row = ctx.config.index("ScoreReward").get(rid)
    drawn = ctx.state.setdefault("consume_drawn", [])
    if row is None or rid in drawn or ctx.counter("gold_consumed") < int(row["needScore"]):
        raise GameError(-2, "cannot draw")
    led = ctx.ledger()
    led.grant(show_spec(row["showType"], row["showId"], 1))
    drawn.append(rid)
    ctx.save()
    return led.rewards


@route(59, 1)
def charge_rank_info(ctx, req):
    return _rank_vo(ctx, int(ctx.wallet.get("totalCharge", 0)), ctx.state.get("chargerank_drawn", []))


@route(59, 2)
def charge_rank_draw(ctx, req):
    rid = int(req.get("_") or 0)
    drawn = ctx.state.setdefault("chargerank_drawn", [])
    if rid in drawn:
        raise GameError(-2, "drawn")
    drawn.append(rid)
    ctx.save()
    return []


# ---------------------------------------------------------------- 58 raffle
def _raffle(ctx):
    r = ctx.state.setdefault("raffle", {"awards": [], "count": 0, "reset": 0})
    if not r["awards"]:
        r["awards"] = random.sample([x["id"] for x in ctx.config.rows("RaffleRewards")], 8)
    return r


def _raffle_cost(ctx, count: int) -> int:
    rows = ctx.config.rows("RaffleCost")
    row = rows[min(count, len(rows) - 1)] if rows else {"costs": "[100]"}
    return int(parse_json(row["costs"], [100])[0])


@route(58, 1)
def raffle_info(ctx, req):
    r = _raffle(ctx)
    ctx.save()
    return {"awards": r["awards"], "count": r["count"], "raffleCount": r["count"], "resetTime": r["reset"]}


@route(58, 2)
def raffle_reset(ctx, req):
    r = _raffle(ctx)
    r.update(awards=[], count=0, reset=now_ms())
    _raffle(ctx)
    ctx.save()
    return {"awards": r["awards"], "costResults": [], "count": 0, "resetTime": r["reset"]}


@route(58, 3)
def raffle_draw(ctx, req):
    r = _raffle(ctx)
    left = [a for a in r["awards"] if a]
    if not left:
        raise GameError(-1, "all drawn")
    led = ctx.ledger()
    led.pay_jade(_raffle_cost(ctx, r["count"]))
    pick = random.choice(left)
    row = ctx.config.index("RaffleRewards").get(pick, {})
    led.grant(show_spec(row.get("showType"), row.get("showId"), row.get("amount") or 1))
    r["awards"] = [a if a != pick else "" for a in r["awards"]]
    r["count"] += 1
    ctx.save()
    return {"awards": r["awards"], "costResults": led.costs, "resetTime": r["reset"], "reward": pick,
            "rewardResults": led.rewards}


# -------------------------------------------------------------- 60 foolsday
def _seg(ctx) -> int:
    levels = ctx.config.value("FOOLSDAY:LEVELS", [300])
    return next((i + 1 for i, lv in enumerate(levels) if ctx.level <= lv), len(levels))


@route(60, 1)
def fools_info(ctx, req):
    f = ctx.state.setdefault("foolsday", {"cards": {}, "resets": 0})
    return {"cards": {int(k): int(v) for k, v in f["cards"].items()}, "levelSegment": _seg(ctx),
            "resetTimes": f["resets"]}


@route(60, 2)  # FLOP {position}
def fools_flop(ctx, req):
    f = ctx.state.setdefault("foolsday", {"cards": {}, "resets": 0})
    pos = int(req.get("position") or 0)
    if str(pos) in f["cards"]:
        raise GameError(-1, "flipped")
    seg = _seg(ctx)
    cards = ctx.config.value("FOOLSDAY:CARDS", [[]])[min(seg, 4)]
    rates = ctx.config.value("FOOLSDAY:RATE", [[]])[min(seg, 4)]
    led = ctx.ledger()
    if len(f["cards"]) >= int(ctx.config.value("FOOLSDAY:FREE_FLOP_LIMIT", 2)):
        led.pay_jade(50)  # 推测值
    card = random.choices(cards, weights=rates)[0] if cards else 311
    led.grant({"type": "HERO", "code": int(card), "amount": 1})
    f["cards"][str(pos)] = int(card)
    ctx.save()
    return {"card": int(card), "costAndReward": led.cost_and_reward(), "levelSegment": seg,
            "resetTimes": f["resets"]}


@route(60, 3)
def fools_reset(ctx, req):
    f = ctx.state.setdefault("foolsday", {"cards": {}, "resets": 0})
    led = ctx.ledger()
    if f["resets"] >= int(ctx.config.value("FOOLSDAY:FREE_RESET_LIMIT", 3)):
        led.pay_jade(50)  # 推测值
    f.update(cards={}, resets=f["resets"] + 1)
    ctx.save()
    return {"costs": led.costs, "levelSegment": _seg(ctx), "resetTimes": f["resets"]}


# -------------------------------------------------------------- 62 qingming
def _qm(ctx):
    return ctx.state.setdefault("qingming", {"count": 0, "score": 0, "pond": 1})


def _qm_page(ctx) -> dict:
    q = _qm(ctx)
    return {"jibaiCount": q["count"], "jiping": ctx.counter("reward_JIPING_0"), "pondId": q["pond"], "score": q["score"]}


@route(62, 1)
def qm_info(ctx, req):
    vo = _rank_vo(ctx, _qm(ctx)["score"], [])
    vo.pop("drawedIds")
    return vo


@route(62, 3)
def qm_page(ctx, req):
    return _qm_page(ctx)


@route(62, 2)  # JIBAI
def qm_jibai(ctx, req):
    q = _qm(ctx)
    pond = ctx.config.index("QingmingPond").get(q["pond"], {})
    cost = int(parse_json(pond.get("jipingCosts"), [100])[0])
    if ctx.counter("reward_JIPING_0") < cost:
        raise GameError(-1, "jiping")
    ctx.add_counter("reward_JIPING_0", -cost)
    rewards = [r for r in ctx.config.rows("QingmingReward") if int(r["pondId"]) == q["pond"]
               and int(r["lowLevel"]) <= ctx.level <= int(r["highLevel"])]
    led = ctx.ledger()
    if rewards:
        row = random.choice(rewards)
        led.grant(show_spec(row["showType"], row["showId"], row["amount"]))
    q["count"] += 1
    q["score"] += cost
    ctx.save()
    return {"pageVo": _qm_page(ctx), "rewards": led.rewards}


# ------------------------------------------------------------ 63 juhuasuan
@route(63, 1)
def ju_info(ctx, req):
    goods = [r["id"] for r in ctx.config.rows("JuGoods") if int(r.get("level") or 0) <= ctx.level]
    bought = ctx.state.get("juhuasuan", [])
    return {"buyedRecords": bought, "canBuy": [g for g in goods[:8] if g not in bought], "canShow": goods[:8]}


@route(63, 2)
def ju_buy(ctx, req):
    gid = str(req.get("goodsId") or "")
    row = ctx.config.index("JuGoods").get(gid)
    bought = ctx.state.setdefault("juhuasuan", [])
    if row is None or gid in bought:
        raise GameError(-1, "goods")
    led = ctx.ledger()
    led.pay_jade(int(row["costs"]))
    led.grant(show_spec(row["showType"], row["showId"], row["amount"]))
    bought.append(gid)
    ctx.save()
    return led.cost_and_reward()


# ------------------------------------------------------------- 64 cheapbuy
@route(64, 1)
def cheap_info(ctx, req):
    mall = int(req.get("mallId") or 0)
    return {"buyIds": list(ctx.state.get("cheapbuy", {}).get(str(mall), [])),
            "charge": int(ctx.wallet.get("totalCharge", 0)), "id": mall}


@route(64, 2)
def cheap_buy(ctx, req):
    row = ctx.config.index("CheapBuySetting").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-1, "goods")
    record = ctx.state.setdefault("cheapbuy", {}).setdefault(str(row["mallId"]), [])
    if row["id"] in record or ctx.level < int(row.get("level") or 0):
        raise GameError(-2, "cannot buy")
    if int(ctx.wallet.get("totalCharge", 0)) < int(row.get("charge") or 0):
        raise GameError(-3, "charge")
    led = ctx.ledger()
    led.pay_jade(int(row["cost"]))
    for kind, sid, n in zip(parse_json(row["showTypes"], []), parse_json(row["showIds"], []),
                            parse_json(row["counts"], [])):
        led.grant(show_spec(kind, sid, n))
    record.append(row["id"])
    ctx.save()
    return {"costAndReward": led.cost_and_reward(), "info": cheap_info(ctx, {"mallId": row["mallId"]})}


# ------------------------------------------------------------- 65 equipgift
@route(65, 1)
def equipgift_info(ctx, req):
    rec = ctx.state.get("equipgift", {})
    return {int(r["id"]): {"times": int(rec.get(str(r["id"]), 0)), "todayTimes": 0}
            for r in ctx.config.rows("GiftGoods")}


@route(65, 2)
def equipgift_buy(ctx, req):
    row = ctx.config.index("GiftGoods").get(int(req.get("goodsId") or 0))
    if row is None:
        raise GameError(-1, "goods")
    rec = ctx.state.setdefault("equipgift", {})
    if int(rec.get(str(row["id"]), 0)) >= int(row.get("totalbuyLimit") or 999):
        raise GameError(-2, "limit")
    led = ctx.ledger()
    led.pay_jade(int(row["cost"]))
    for kind, sid, n in zip(parse_json(row["showTypeId"], []), parse_json(row["showIds"], []),
                            parse_json(row["counts"], [])):
        led.grant(show_spec(kind, sid, n))
    rec[str(row["id"])] = int(rec.get(str(row["id"]), 0)) + 1
    ctx.save()
    return {"costResults": led.costs, "randomRewardResults": [], "rewardResults": led.rewards}


# -------------------------------------------------------------- 66 football
@route(66, 1)
def football_info(ctx, req):
    f = ctx.state.setdefault("football", {"used": 0, "bought": 0, "point": 0})
    return {"buyBalls": f["bought"], "level": 1, "point": f["point"], "resetTimes": 0,
            "shootData": {}, "usedFreeBalls": f["used"]}


def _shoot(ctx, pay: bool):
    f = ctx.state.setdefault("football", {"used": 0, "bought": 0, "point": 0})
    led = ctx.ledger()
    if pay:
        led.pay_jade(int(ctx.config.value("FOOTBALL:SHOOT_COST", 200)))
        f["bought"] += 1
    else:
        free = int((ctx.config.rows("FootballPoints") or [{"freeBalls": 3}])[0]["freeBalls"])
        if f["used"] >= free:
            raise GameError(-1, "no free balls")
        f["used"] += 1
    if random.random() < 0.5:  # 推测值: goal chance
        f["point"] += 1
        rows = ctx.config.rows("BallReward")
        if rows:
            row = rows[0]
            i = random.randrange(3)
            led.grant(show_spec(parse_json(row["showTypeId"], [[]])[0][i],
                                parse_json(row["showIds"], [[]])[0][i],
                                parse_json(row["counts"], [[]])[0][i]))
    ctx.save()
    return led


@route(66, 2)
def football_shoot(ctx, req):
    return _shoot(ctx, False).rewards


@route(66, 3)
def football_shoot_paid(ctx, req):
    led = _shoot(ctx, True)
    return {"costResults": led.costs, "rewardResults": led.rewards}


# ------------------------------------------------------------ 67 supergift
@route(67, 1)  # GET_INFO [mallId]
def super_info(ctx, req):
    mall = int(req.get("_") or 0)
    rec = ctx.state.get("supergift", {})
    return [{"buyCount": int(rec.get(str(r["id"]), 0)), "id": int(r["id"]),
             "totalLeft": int(r["total"]) - int(rec.get(str(r["id"]), 0))}
            for r in ctx.config.rows("SuperGoods") if int(r["mallId"]) == mall]


@route(67, 2)
def super_buy(ctx, req):
    row = ctx.config.index("SuperGoods").get(int(req.get("goodsId") or 0))
    if row is None:
        raise GameError(-1, "goods")
    rec = ctx.state.setdefault("supergift", {})
    if int(rec.get(str(row["id"]), 0)) >= int(row["single"]):
        raise GameError(-2, "limit")
    led = ctx.ledger()
    led.pay_jade(int(row["cost"]), ctx.config.value("SUPER_GIFT:COST_TYPE"))
    led.grant(show_spec(row["showType"], row["showId"], row["count"]))
    rec[str(row["id"])] = int(rec.get(str(row["id"]), 0)) + 1
    ctx.save()
    return {"costAndReward": led.cost_and_reward(), "showList": super_info(ctx, {"_": row["mallId"]})}


# ------------------------------------------------------------- 69 blessing
@route(69, 1)
def blessing_info(ctx, req):
    b = ctx.state.setdefault("blessing", {"rank": 1, "times": 0})
    return {"charge": int(ctx.wallet.get("totalCharge", 0)), "rank": b["rank"], "times": b["times"],
            "totalTimes": b["times"]}


@route(69, 2)
def blessing_lottery(ctx, req):
    b = ctx.state.setdefault("blessing", {"rank": 1, "times": 0})
    led = ctx.ledger()
    led.pay_jade(100)  # 推测值
    idx = min(b["rank"], 3) - 1
    kinds = ctx.config.value(f"BLESSING:FAKE_REWARDS_SHOWTYPES_{b['rank'] + 1}",
                             ctx.config.value("BLESSING:FAKE_REWARDS_SHOWTYPES_2", [[]]))[idx]
    ids = ctx.config.value(f"BLESSING:FAKE_REWARDS_SHOWIDS_{b['rank'] + 1}",
                           ctx.config.value("BLESSING:FAKE_REWARDS_SHOWIDS_2", [[]]))[idx]
    amounts = ctx.config.value(f"BLESSING:FAKE_REWARDS_AMOUNTS_{b['rank'] + 1}",
                               ctx.config.value("BLESSING:FAKE_REWARDS_AMOUNTS_2", [[]]))[idx]
    i = random.randrange(len(kinds)) if kinds else 0
    if kinds:
        kind = kinds[i] if kinds[i] not in ("ACTION", "SOUL_STONE") else kinds[i]
        led.grant(show_spec(kind, ids[i], amounts[i]))
    b["times"] += 1
    b["rank"] = min(3, b["rank"] + (1 if random.random() < 0.3 else 0))
    ctx.save()
    return {"costResults": led.costs, "rank": b["rank"], "rewardResults": [led.rewards]}


# ------------------------------------------------------------ 73 godreward
def _god(ctx):
    g = ctx.state.setdefault("godreward", {"tasks": [], "accepted": {}, "done": [], "feats": 0,
                                           "rewardFeats": [], "free": 0, "buy": 0, "day": ""})
    if g["day"] != _today():
        g.update(day=_today(), free=0, buy=0)
        g["tasks"] = random.sample([r["id"] for r in ctx.config.rows("GodTaskSetting")],
                                   min(int(ctx.config.value("GODREWARD:REFRESH_TASKS_NUM", 3)),
                                       len(ctx.config.rows("GodTaskSetting"))))
    return g


def _god_progress(ctx, g) -> dict:
    # progress = campaign clears since accepting (CROSS_BATTLE_NUM targets)
    clears = sum(int(v) for v in ctx.state.get("daily_counts", {}).values())
    return {int(k): float(clears - int(v)) for k, v in g["accepted"].items()}


@route(73, 1)
def god_info(ctx, req):
    g = _god(ctx)
    ctx.save()
    return {"buyTimes": g["buy"], "feats": g["feats"], "freeTimes": g["free"], "progress": _god_progress(ctx, g),
            "rewardFeats": g["rewardFeats"], "rewardTasks": g["done"], "tasks": g["tasks"]}


def _god_refresh(ctx, paid: bool):
    g = _god(ctx)
    led = ctx.ledger()
    if paid:
        costs = ctx.config.value("GODREWARD:BUY_REFRESH_COSTS", [50])
        led.pay_jade(int(costs[min(g["buy"], len(costs) - 1)]))
        g["buy"] += 1
    else:
        if g["free"] >= int(ctx.config.value("GODREWARD:FREE_REFRESH_LIMIT", 22)):
            raise GameError(-1, "free refresh used")
        g["free"] += 1
    g["tasks"] = random.sample([r["id"] for r in ctx.config.rows("GodTaskSetting")], len(g["tasks"]) or 3)
    ctx.save()
    return {"buyTimes": g["buy"], "costResults": led.costs, "freeTimes": g["free"], "tasks": g["tasks"]}


@route(73, 2)
def god_refresh(ctx, req):
    return _god_refresh(ctx, False)


@route(73, 3)
def god_buy_refresh(ctx, req):
    return _god_refresh(ctx, True)


@route(73, 4)  # ACCEPT_TASK [id]
def god_accept(ctx, req):
    g = _god(ctx)
    tid = int(req.get("_") or 0)
    if tid not in g["tasks"]:
        raise GameError(-2, "no task")
    g["accepted"][str(tid)] = sum(int(v) for v in ctx.state.get("daily_counts", {}).values())
    ctx.save()
    return _god_progress(ctx, g)


@route(73, 5)
def god_give_up(ctx, req):
    g = _god(ctx)
    g["accepted"].pop(str(int(req.get("_") or 0)), None)
    ctx.save()
    return {"freeTimes": g["free"], "progress": _god_progress(ctx, g), "tasks": g["tasks"]}


@route(73, 6)  # GET_TASK_REWARD [id]
def god_task_reward(ctx, req):
    g = _god(ctx)
    tid = int(req.get("_") or 0)
    row = ctx.config.index("GodTaskSetting").get(tid)
    if row is None or str(tid) not in g["accepted"] or _god_progress(ctx, g)[tid] < int(row["target"]):
        raise GameError(-3, "not complete")
    led = ctx.ledger()
    led.grant(show_spec(row["showType"], row["showId"], 50000))  # 推测值 amount
    g["feats"] += int(row["feats"])
    g["accepted"].pop(str(tid))
    g["done"].append(tid)
    ctx.save()
    return {"freeTimes": g["free"], "rewardResults": led.rewards, "tasks": g["tasks"]}


@route(73, 7)  # GET_FEAT_REWARD [id]: GodFeatSetting
def god_feat_reward(ctx, req):
    g = _god(ctx)
    row = ctx.config.index("GodFeatSetting").get(int(req.get("_") or 0))
    if row is None or row["id"] in g["rewardFeats"] or g["feats"] < int(row["feats"]):
        raise GameError(-4, "cannot draw")
    led = ctx.ledger()
    led.grant(show_spec(row["showType"], row["showId"], row["amount"]))
    g["rewardFeats"].append(row["id"])
    ctx.save()
    return {"rewardFeats": g["rewardFeats"], "rewardResults": led.rewards}


# ------------------------------------------------------------------ 74 moon
MOONS = ["MOON", "HUA", "HAO", "YUE", "YUAN"]


def _moon_counts(ctx) -> dict:
    return {i: ctx.counter(f"reward_MOON_{i}") for i in range(5)}


@route(74, 1)
def moon_info(ctx, req):
    return {"count": _moon_counts(ctx), "post": []}


@route(74, 2)  # COMPOSE_MOON {count}: 花好月圆 -> 月饼
def moon_compose(ctx, req):
    count = max(1, int(req.get("count") or 1))
    need = ctx.config.value("MOON:COMPOSE", {"HUA": 1, "HAO": 1, "YUE": 1, "YUAN": 1})
    for name, n in need.items():
        if ctx.counter(f"reward_MOON_{MOONS.index(name)}") < int(n) * count:
            raise GameError(-1, "materials")
    for name, n in need.items():
        ctx.add_counter(f"reward_MOON_{MOONS.index(name)}", -int(n) * count)
    ctx.add_counter("reward_MOON_0", count)
    return {"composeCount": count, "curCount": _moon_counts(ctx)}


@route(74, 3)  # BUY_MOON {count, type}
def moon_buy(ctx, req):
    kind, count = int(req.get("type") or 0), max(1, int(req.get("count") or 1))
    price = ctx.config.value("MOON:BUY_COST", {}).get(MOONS[kind], 20)
    led = ctx.ledger()
    led.pay_jade(int(price) * count, ctx.config.value("MOON:BUY_COST_TYPE"))
    ctx.add_counter(f"reward_MOON_{kind}", count)
    return {"costs": led.costs, "curCount": _moon_counts(ctx)}


@route(74, 4)  # EXHCNAGE {group}: MoonExSetting
def moon_exchange(ctx, req):
    rows = [r for r in ctx.config.rows("MoonExSetting") if int(r["group"]) == int(req.get("group") or 0)]
    if not rows:
        raise GameError(-2, "group")
    row = random.choice(rows)
    for cost in parse_json(row["costs"], []):
        key = f"reward_MOON_{int(cost['code'])}"
        if ctx.counter(key) < int(cost["amount"]):
            raise GameError(-1, "moon cakes")
        ctx.add_counter(key, -int(cost["amount"]))
    led = ctx.ledger()
    shown = ctx.config.value("MOON:SHOW_BASEID", [6247])
    led.grant({"type": "FRAGMENT", "code": int(random.choice(shown)), "amount": 1})
    return {"costResults": led.costs, "curCount": _moon_counts(ctx), "rewardResults": led.rewards}


# ------------------------------------------------------------------ 78 slot
@route(78, 1)
def slot_info(ctx, req):
    s = ctx.state.setdefault("slot", {"day": "", "free": 0, "cost": 0, "records": []})
    if s["day"] != _today():
        s.update(day=_today(), free=0)
    return {"buyTimes": ctx.counter("reward_SLOT_LOTTERY_TIMES_0"), "costtimes": s["cost"],
            "freetimes": int(ctx.config.value("SLOT:FREE_TIMES", 1)) - s["free"],
            "positionRewards": {}, "records": []}


@route(78, 2)  # LOTTERY {currency}
def slot_lottery(ctx, req):
    s = ctx.state.setdefault("slot", {"day": _today(), "free": 0, "cost": 0, "records": []})
    led = ctx.ledger()
    if req.get("currency"):
        costs = ctx.config.value("SLOT:TIMES_COST", [80])
        led.pay_jade(int(costs[min(s["cost"], len(costs) - 1)]))
        s["cost"] += 1
    elif s["free"] < int(ctx.config.value("SLOT:FREE_TIMES", 1)):
        s["free"] += 1
    elif ctx.counter("reward_SLOT_LOTTERY_TIMES_0") > 0:
        ctx.add_counter("reward_SLOT_LOTTERY_TIMES_0", -1)
    else:
        raise GameError(-1, "no times")
    multiples = ctx.config.value("SLOT:MULTIPLE", [1])
    pos = random.randrange(len(multiples))
    rows = ctx.config.rows("SlotReward")
    if rows:
        row = random.choice(rows)
        led.grant(show_spec(row["showType"], row["showId"], int(row["amount"]) * int(multiples[pos])))
    ctx.save()
    return {"appearPosition": pos + 1, "costResults": led.costs, "positionRewards": {},
            "records": [], "rewardResults": led.rewards}


# ------------------------------------------------------------ 80 exchange
@route(80, 1)
def ex_info(ctx, req):
    return {"buyTimes": {int(k): int(v) for k, v in ctx.state.get("sweet_exchange", {}).items()},
            "sweets": {i: ctx.counter(f"reward_SWEET_{i}") for i in range(4)}}


@route(80, 2)  # LOAD_EXCHANGE {heros, id}: ExchangeSetting
def ex_exchange(ctx, req):
    row = ctx.config.index("ExchangeSetting").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-1, "no exchange")
    rec = ctx.state.setdefault("sweet_exchange", {})
    if int(rec.get(str(row["id"]), 0)) >= int(row.get("limit") or 1):
        raise GameError(-2, "limit")
    for cost in parse_json(row["costItems"], []):
        key = f"reward_{cost['type']}_{int(cost['code'])}"
        if ctx.counter(key) < int(cost["amount"]):
            raise GameError(-3, "materials")
        ctx.add_counter(key, -int(cost["amount"]))
    led = ctx.ledger()
    for value in req.get("heros") or []:
        card = ctx.card(as_id(value))
        if card:
            led.pay_card(card)
    led.grant_reward_id(row["rewardId"])
    rec[str(row["id"])] = int(rec.get(str(row["id"]), 0)) + 1
    ctx.save()
    return {"costResults": led.costs, "rewardResults": led.rewards}


# ------------------------------------------------------------- 82 turkey
def _turkey_vo(ctx) -> dict:
    return {"materials": {1: ctx.counter("reward_TURKEY_1"), 2: ctx.counter("reward_TURKEY_2")},
            "records": [], "times": 0, "turkeys": ctx.counter("reward_TURKEY_0")}


@route(82, 1)
def turkey_info(ctx, req):
    return _turkey_vo(ctx)


@route(82, 2)  # BUY_MATERIAL {count, materialType}
def turkey_buy(ctx, req):
    kind, count = int(req.get("materialType") or 1), max(1, int(req.get("count") or 1))
    row = ctx.config.index("TurkeyMaterial").get(kind, {"price": 10})
    led = ctx.ledger()
    led.pay_jade(int(row["price"]) * count, ctx.config.value("TURKEY:COST_CURRENCY_TYPE"))
    led.grant({"type": "TURKEY", "code": kind, "amount": count})
    return led.cost_and_reward()


def _make_turkey(ctx, count: int, by_currency: bool):
    led = ctx.ledger()
    if by_currency:
        led.pay_jade(int(ctx.config.value("TURKEY:COST_CURRENCY", 40)) * count)
    else:
        for cost in ctx.config.value("TURKEY:COST_MATERIALS", []):
            key = f"reward_TURKEY_{int(cost['code'])}"
            if ctx.counter(key) < int(cost["amount"]) * count:
                raise GameError(-1, "materials")
            ctx.add_counter(key, -int(cost["amount"]) * count)
    led.grant({"type": "TURKEY", "code": 0, "amount": count})
    return led.cost_and_reward()


@route(82, 3)
def turkey_make(ctx, req):
    return _make_turkey(ctx, max(1, int(req.get("count") or 1)), False)


@route(82, 4)
def turkey_make_cost(ctx, req):
    return _make_turkey(ctx, max(1, int(req.get("count") or 1)), True)


@route(82, 5)  # EAT_TURKEY {count}
def turkey_eat(ctx, req):
    count = max(1, int(req.get("count") or 1))
    if ctx.counter("reward_TURKEY_0") < count:
        raise GameError(-2, "no turkey")
    ctx.add_counter("reward_TURKEY_0", -count)
    led = ctx.ledger()
    for _ in range(count):
        led.grant_reward_id(ctx.config.value("TURKEY:EAT_REWARD", ""))
    return {"costAndReward": led.cost_and_reward(), "records": []}


# ------------------------------------------------------------- 84 recycle
@route(84, 1)  # RECYCLE {cost, recycleThings}: RecycleSetting pools (cards)
def recycle(ctx, req):
    things = req.get("recycleThings") or {}
    led = ctx.ledger()
    table = ctx.config.index("RecycleSetting")
    for value in things.get("heroIds") or []:
        card = ctx.card(as_id(value))
        if card is None:
            continue
        info = ctx.config.heroes.get(int(card["base_id"]), {})
        row = table.get(f"CARD_TYPE:{info.get('card')}:{info.get('rank')}:{info.get('star')}")
        if row is None:
            raise GameError(-1, "cannot recycle")
        if req.get("cost"):
            led.pay_jade(int(parse_json(row.get("costs"), [0])[0]), ctx.config.value("RECYCLE:COST_TYPE"))
            led.grant_all(parse_json(row.get("goldCounts"), []))
        led.pay_card(card)
        led.grant_all(parse_json(row.get("fixCounts"), []))
    for value in things.get("equipIds") or []:
        from .equip import melt
        led.rewards.extend([])
        melt(ctx, {"ids": [value], "materials": {}})
    return led.cost_and_reward()
