"""MsgPlayer (mod 11), MsgPoint (mod 21) and MsgSystem (mod 0)."""

from __future__ import annotations

import random
import time

from ..game import (
    CURRENCY, Context, GameError, charge_times, now_ms, parse_json, point_value, refresh_points, route,
)
from ..storage import InvalidRoleError, validate_role_name

ARGUMENT_ILLEGAL = -1
NOT_ENOUGH_LEVEL = -3
TODAY_HAS_CHECKED = -13
TOKEN_COIN_NOT_ENOUGH = -15
EXCHANGE_TIMES_LIMIT = -21
ROULETTE_LOTTERY_LEVEL_LIMIT = -10
OPEN_BETA_GOODS_BUY_NUM_LIMIT = -18

DAY_MS = 86_400_000


def today() -> str:
    return time.strftime("%Y%m%d")


def show_spec(show_type: str, show_id, amount) -> dict:
    """Map a display triple (showType/showId/amount) to a reward spec."""
    show_type = str(show_type)
    amount = int(str(amount).replace("万", "0000") or 1) if amount not in ("", None) else 1
    if show_type in CURRENCY:
        return {"type": "CURRENCY", "code": CURRENCY.index(show_type), "amount": amount}
    if show_type == "ACTION":
        return {"type": "ACTION_POINT", "code": 0, "amount": amount}
    return {"type": show_type, "code": int(show_id or 0), "amount": amount}


# ---------------------------------------------------------------- VIP
def vip_info(ctx: Context) -> dict:
    vip = ctx.state.get("vip", {})
    now = now_ms()
    until = int(vip.get("vipTime", 0))
    month = int(vip.get("monthTime", 0))
    week = int(vip.get("weekTime", 0))
    return {"vip": until > now, "vipTime": until, "monsth": month > now, "monsthTime": month,
            "week": week > now, "weekTime": week, "lastChargeDate": int(vip.get("lastCharge", 0))}


@route(11, 2)  # WALLET
def wallet(ctx: Context, req: dict):
    keys = ("copper", "coupon", "exploit", "fragment", "friendship", "gift", "gold",
            "inter", "orange", "purple", "stone", "totalCharge")
    value = {key: int(ctx.wallet.get(key, 0)) for key in keys}
    value["stageCharges"] = dict(ctx.wallet.get("stageCharges", {}))
    return value


@route(11, 3)  # VIP
def vip(ctx: Context, req: dict):
    return vip_info(ctx)


@route(11, 8)  # RESETNAME
def reset_name(ctx: Context, req: dict):
    name = str(req.get("_") if "_" in req else req.get("name") or "")
    if isinstance(req.get("_"), list):
        name = str(req["_"][0])
    try:
        validate_role_name(name)
        ctx.server.repository.rename(ctx.account, name)
    except InvalidRoleError as error:
        raise GameError(ARGUMENT_ILLEGAL, str(error)) from error
    except ValueError as error:
        raise GameError(-3, "name exists") from error
    ctx.state["renamed"] = True
    ctx.save()
    return 0


@route(11, 14)  # GET_BUFFS
def get_buffs(ctx: Context, req: dict):
    return list(ctx.state.get("buffs", []))


# ---------------------------------------------------------- daily check
def _check_tables(ctx: Context):
    period = int(ctx.config.value("PLAYER:DAILY_CHECK_PERIOD", 7) or 7)
    first = int(ctx.state.get("daily_check", {}).get("cycles", 0)) == 0
    table = "FirstDailyCheckConfig" if first else "DailyCheckConfig"
    return period, first, ctx.config.rows(table)


def _segment(ctx: Context) -> int:
    return int(ctx.config.levels.get(ctx.level, {}).get("dailyCheckSegment") or 1)


def _check_state(ctx: Context) -> dict:
    check = ctx.state.setdefault("daily_check", {"cycles": 0, "days": 0, "ids": [], "last": ""})
    period, _, _ = _check_tables(ctx)
    if int(check.get("days", 0)) >= period and check.get("last") != today():
        check.update(cycles=int(check.get("cycles", 0)) + 1, days=0, ids=[])
        ctx.save()
    return check


@route(11, 12)  # DAILY_CHECK_INFO
def daily_check_info(ctx: Context, req: dict):
    check = _check_state(ctx)
    _, first, _ = _check_tables(ctx)
    return {"checkedIds": list(check["ids"]), "continueDays": int(check["days"]),
            "first": first, "refreshTime": now_ms(), "segment": _segment(ctx)}


@route(11, 13)  # DAILY_CHECK_IN
def daily_check_in(ctx: Context, req: dict):
    check = _check_state(ctx)
    if check.get("last") == today():
        raise GameError(TODAY_HAS_CHECKED, "checked today")
    _, _, rows = _check_tables(ctx)
    day = int(check["days"]) + 1
    segment = _segment(ctx)
    row = next((r for r in rows if int(r["continueDay"]) == day
                and int(r["levelSegment"]) == segment), None) \
        or next((r for r in rows if int(r["continueDay"]) == day), None)
    ledger = ctx.ledger()
    if row is not None:
        if row.get("rewardType") == "CONFIG" and row.get("showType") == "MYSTCARD":
            # 推测值: 神秘卡 = random hero card of star showId
            pool = [h["id"] for h in ctx.config.rows("BaseHero")
                    if h["card"] == "HERO" and int(h["star"]) == int(row["showId"])]
            ledger.grant({"type": "HERO", "code": random.choice(pool), "amount": 1})
        else:
            ledger.grant(show_spec(row["showType"], row["showId"], row["amount"]))
        check["ids"].append(int(row["id"]))
    check.update(days=day, last=today())
    ctx.save()
    return {"checkedIds": list(check["ids"]), "continueDays": day,
            "rewardResults": ledger.rewards, "segment": segment}


# ------------------------------------------------------------ roulette
def _roulette_level(ctx: Context) -> int:
    levels = ctx.config.value("PLAYER:ROULETTE_LOTTERY_LEVEL", [])
    used = set(ctx.state.get("roulette_levels", []))
    return next((lv for lv in levels if lv <= ctx.level and lv not in used), -1)


@route(11, 9)  # ROULETTE_LOTTERY: one free spin per unlocked level milestone
def roulette_lottery(ctx: Context, req: dict):
    level = _roulette_level(ctx)
    if level < 0:
        raise GameError(ROULETTE_LOTTERY_LEVEL_LIMIT, "no spin available")
    rows = [r for r in ctx.config.rows("RouletteLotteryConfig") if int(r["level"]) == level]
    row = random.choice(rows)
    ledger = ctx.ledger()
    ledger.grant_reward_id(row["rewardId"])
    ctx.state.setdefault("roulette_levels", []).append(level)
    results = ctx.state.setdefault("roulette_results", [])
    results.insert(0, int(row["id"]))
    del results[int(ctx.config.value("PLAYER:ROULETTE_LOTTERY_RESULT_SIZE", 5)):]
    ctx.save()
    levels = ctx.config.value("PLAYER:ROULETTE_LOTTERY_LEVEL", [])
    upcoming = [lv for lv in levels if lv not in ctx.state["roulette_levels"]]
    return {"id": int(row["id"]), "nextLevel": upcoming[0] if upcoming else -1,
            "rewardResults": ledger.rewards}


@route(11, 10)  # ROULETTE_LOTTERY_RESULTS
def roulette_results(ctx: Context, req: dict):
    return [{"configId": cid, "userName": ctx.record.role_name}
            for cid in ctx.state.get("roulette_results", [])]


# ---------------------------------------------------------- token coin
@route(11, 15)  # GET_ACTIVITY_MONEY
def get_activity_money(ctx: Context, req: dict):
    mall = str(int(req.get("mallId") or 0))
    record = ctx.state.get("token_exchange", {}).get(mall, {})
    return {"tokenCoin": ctx.counter("token_coin_" + mall) + ctx.counter("reward_TOKEN_COIN_0"),
            "exchangeTimes": {int(k): int(v) for k, v in record.items()}}


@route(11, 16)  # TOKEN_COIN_EXCHANGE
def token_coin_exchange(ctx: Context, req: dict):
    row = ctx.config.index("TokenCoinConfig").get(int(req.get("id") or 0))
    num = int(req.get("num") or 1)
    if row is None or num <= 0 or num > int(ctx.config.value("PLAYER:TOKEN_COIN_EXCHANGE_MAX_NUM", 100)):
        raise GameError(ARGUMENT_ILLEGAL, "bad exchange")
    if not int(row["minLevel"]) <= ctx.level <= int(row["maxLevel"]):
        raise GameError(NOT_ENOUGH_LEVEL, "level")
    mall = str(int(row["mallId"]))
    record = ctx.state.setdefault("token_exchange", {}).setdefault(mall, {})
    used = int(record.get(str(row["id"]), 0))
    if int(row.get("limit") or 0) and used + num > int(row["limit"]):
        raise GameError(EXCHANGE_TIMES_LIMIT, "limit")
    cost = int(row["costTokenCoin"]) * num
    coins = ctx.counter("reward_TOKEN_COIN_0")
    if coins < cost:
        raise GameError(TOKEN_COIN_NOT_ENOUGH, "token coin")
    ctx.add_counter("reward_TOKEN_COIN_0", -cost)
    ledger = ctx.ledger()
    for _ in range(num):
        ledger.grant(show_spec(row["showType"], row["showId"], 1))
    record[str(row["id"])] = used + num
    ctx.save()
    return {"rewardResult": ledger.rewards, "tokenCoin": ctx.counter("reward_TOKEN_COIN_0")}


# ------------------------------------------------------ open beta goods
@route(11, 18)  # GET_OPEN_BETA_GOODS_INFO
def open_beta_info(ctx: Context, req: dict):
    return {int(k): int(v) for k, v in ctx.state.get("open_beta", {}).items()}


@route(11, 19)  # BUY_OPEN_BETA_GOODS
def buy_open_beta(ctx: Context, req: dict):
    row = ctx.config.index("OpenBetaGoodsConfig").get(int(req.get("goodsId") or 0))
    if row is None:
        raise GameError(ARGUMENT_ILLEGAL, "goods")
    bought = ctx.state.setdefault("open_beta", {})
    count = int(bought.get(str(row["id"]), 0))
    if count >= int(row.get("limit") or 1):
        raise GameError(OPEN_BETA_GOODS_BUY_NUM_LIMIT, "limit")
    ledger = ctx.ledger()
    ledger.pay_jade(int(parse_json(row.get("price"), [0])[0]))
    for kind, show_id, amount in zip(parse_json(row["showTypes"], []),
                                     parse_json(row["showIds"], []),
                                     parse_json(row["counts"], [])):
        if kind.startswith("TOKEN_COIN"):
            ledger.grant({"type": "TOKEN_COIN", "code": 0, "amount": int(amount)})
        else:
            ledger.grant(show_spec(kind, show_id, amount))
    bought[str(row["id"])] = count + 1
    ctx.save()
    return {"buyGoods": {int(k): int(v) for k, v in bought.items()},
            "costResults": ledger.costs, "fixedRewardResults": ledger.rewards,
            "randomRewardResults": []}


# ------------------------------------------------------------- points
@route(21, 2)  # CURRENT_POINT
def current_point(ctx: Context, req: dict):
    return {"points": {kind: point_value(ctx, kind) for kind in (0, 1, 2)}}


@route(21, 1)  # BUY_SINGLE: buy 100 stamina, price rises per purchase today
def buy_single(ctx: Context, req: dict):
    refresh_points(ctx)
    costs = ctx.config.value("POINT:SINGLE_BUY_COST", [50])
    count = int(ctx.config.value("POINT:SINGLE_BUY_COUNT", 100))
    exchange = ctx.state.setdefault("point_exchange", {}).setdefault("0", {})
    if exchange.get("day") != today():
        exchange.update(day=today(), count=0)
    times = int(exchange["count"])
    limit = charge_times(ctx, "ACTION_POINT")
    if times >= limit:
        raise GameError(-2, "buy times limit")
    ledger = ctx.ledger()
    ledger.pay_jade(int(costs[min(times, len(costs) - 1)]),
                    ctx.config.value("POINT:SINGLE_BUY_TYPE"))
    ledger.grant({"type": "ACTION_POINT", "code": 0, "amount": count})
    exchange["count"] = times + 1
    ctx.save()
    return ledger.cost_and_reward()


# ------------------------------------------------------------- system
@route(0, 2)  # SYSTEM_TIME
def system_time(ctx: Context, req: dict):
    return now_ms()
