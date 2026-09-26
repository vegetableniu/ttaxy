"""Recharge (free in the local build) and recharge-driven features.

ORDER credits the ChargeGoods reward immediately (first purchase uses
firstReward); the client then polls VIP/WALLET after the SDK call and sees
the new balance.  totalCharge is counted in jade (discount / 10), the unit
the Charge2Times / ChargeReward thresholds use.
Monthly/weekly cards return jade daily by system mail (amounts from the
goods descriptions: 月卡 100, 周卡 60, 不值卡 180).
"""

from __future__ import annotations

import time

from ..game import Context, GameError, now_ms, parse_json, route
from .email import send_system_mail

CARD_DAILY = {"vipTime": ("月卡", 100), "weekTime": ("周卡", 60), "monthTime": ("不值卡", 180)}


def _today() -> str:
    return time.strftime("%Y%m%d")


def _goods(ctx: Context, goods_id: str) -> dict:
    row = ctx.config.index("ChargeGoods").get(str(goods_id))
    if row is None:
        raise GameError(-1, "unknown goods")
    return row


def apply_charge(ctx: Context, goods_id: str, count: int = 1):
    row = _goods(ctx, goods_id)
    bought = ctx.state.setdefault("charged_goods", {})
    ledger = ctx.ledger()
    for _ in range(max(1, count)):
        first = int(bought.get(str(goods_id), 0)) == 0
        ledger.grant_all(parse_json(row["firstReward"] if first else row["reward"], []))
        bought[str(goods_id)] = int(bought.get(str(goods_id), 0)) + 1
        jade = int(row.get("discount") or row.get("price") or 0) // 10
        ctx.wallet["totalCharge"] = int(ctx.wallet.get("totalCharge", 0)) + jade
        ctx.add_counter("charge_today_" + _today(), jade)
        ctx.state.setdefault("vip", {})["lastCharge"] = now_ms()
    ctx.save()
    return ledger


def daily_card_returns(ctx: Context) -> None:
    """Mail today's jade return for every active month/week card (once a day)."""
    vip = ctx.state.get("vip", {})
    sent = ctx.state.setdefault("card_returns", {})
    for key, (name, jade) in CARD_DAILY.items():
        if int(vip.get(key, 0)) > now_ms() and sent.get(key) != _today():
            send_system_mail(ctx, 1, [{"type": "CURRENCY", "code": 1, "amount": jade}],
                             title=f"{name}每日返还", content=f"{name}今日返还{jade}仙玉，请查收。")
            sent[key] = _today()
            ctx.save()


@route(11, 4)  # ORDER {amount, channel, goods, imei, mac, version}
def order(ctx: Context, req: dict):
    goods_id = str(req.get("goods") or "")
    count = max(1, int(req.get("amount") or 1))
    row = _goods(ctx, goods_id)
    apply_charge(ctx, goods_id, count)
    serial = int(ctx.state.get("next_order", 0)) + 1
    ctx.state["next_order"] = serial
    ctx.save()
    return {"addition": f"{goods_id}*{count}", "money": int(row.get("price") or 0) * count,
            "serial": serial, "uniPayOrder": f"LOCAL{serial:08d}", "url": ""}


# ---------------------------------------------------------- activity charge
@route(90, 1)  # LOAD_INFO: 充值活动累计
def activity_charge_info(ctx: Context, req: dict):
    return {"charge": int(ctx.wallet.get("totalCharge", 0)),
            "draw": list(ctx.state.get("activity_charge_draw", []))}


@route(90, 2)  # DRAW {id}
def activity_charge_draw(ctx: Context, req: dict):
    row = ctx.config.index("ChargeReward").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-3, "no such reward")
    drawn = ctx.state.setdefault("activity_charge_draw", [])
    if row["id"] in drawn:
        raise GameError(-4, "already drawn")
    if int(ctx.wallet.get("totalCharge", 0)) < int(row["charge"]):
        raise GameError(-2, "charge not enough")
    ledger = ctx.ledger()
    for kind, show_id, amount in zip(parse_json(row["showTypes"], []),
                                     parse_json(row["showIds"], []),
                                     parse_json(row["amounts"], [])):
        if kind.startswith("TOKEN_COIN"):
            ledger.grant({"type": "TOKEN_COIN", "code": 0, "amount": int(amount)})
        else:
            from .player import show_spec
            ledger.grant(show_spec(kind, show_id, amount))
    drawn.append(row["id"])
    ctx.save()
    return ledger.rewards


# ------------------------------------------------------------ charge return
@route(83, 1)  # LOAD_CHARGERETURN: 每日累充返还 (DateReturn, dates made current)
def load_charge_return(ctx: Context, req: dict):
    return {"charge": ctx.counter("charge_today_" + _today()), "day": _today(),
            "drawRecord": list(ctx.state.get("charge_return", {}).get(_today(), []))}


@route(83, 2)  # DRAW_REWARD {ids}
def draw_charge_return(ctx: Context, req: dict):
    record = ctx.state.setdefault("charge_return", {}).setdefault(_today(), [])
    table = ctx.config.index("DateReturn")
    ledger = ctx.ledger()
    from .player import vip_info
    vip = vip_info(ctx)
    for rid in req.get("ids") or []:
        row = table.get(str(rid))
        if row is None:
            raise GameError(-2, "no such return")
        if rid in record:
            raise GameError(-4, "drawn")
        if row.get("vip") == "true" and not vip["vip"]:
            raise GameError(-6, "need vip")
        if row.get("week") == "true" and not vip["week"]:
            raise GameError(-5, "need week card")
        if ctx.counter("charge_today_" + _today()) < int(row.get("charge") or 0):
            raise GameError(-7, "charge not enough")
        ledger.grant_reward_id(row["rewardId"])
        record.append(rid)
    ctx.save()
    return ledger.rewards


# ---------------------------------------------------------------- group buy
@route(46, 1)  # GET_REWARD {baseId}: 团购礼包 (bots fill the buyer count)
def groupbuy_reward(ctx: Context, req: dict):
    row = ctx.config.index("GroupbuyRewardSetting").get(int(req.get("baseId") or 0))
    if row is None:
        raise GameError(-5, "no such reward")
    got = ctx.state.setdefault("groupbuy", [])
    if row["id"] in got:
        raise GameError(-4, "already got")
    from .player import vip_info
    vip = vip_info(ctx)
    if row.get("userType") == "MONTH" and not vip["vip"]:
        raise GameError(-2, "month card required")
    if row.get("userType") == "WEEK" and not (vip["week"] or vip["vip"]):
        raise GameError(-3, "week card required")
    if int(ctx.wallet.get("totalCharge", 0)) <= 0:
        raise GameError(-1, "charge first")
    ledger = ctx.ledger()
    ledger.grant_reward_id(row["rewardId"])
    got.append(row["id"])
    ctx.save()
    return ledger.rewards


@route(46, 2)  # LOAD_REWARD_INFO
def groupbuy_info(ctx: Context, req: dict):
    top = max((int(r["count"]) for r in ctx.config.rows("GroupbuyRewardSetting")), default=0)
    # 单机: simulated buyers always reach every tier
    return {"baseRewardIds": list(ctx.state.get("groupbuy", [])), "chargeCount": top,
            "monthPlayers": top, "weekPlayers": top}


# ------------------------------------------------------------------ deposit
@route(31, 1)  # GET_DEPOSIT_INFO (理财: deposit jade, withdraw with interest)
def deposit_info(ctx: Context, req: dict):
    return _deposit_vo(ctx)


def _deposit_vo(ctx: Context) -> dict:
    deposit = ctx.state.get("deposit", {})
    days = 0
    if deposit:
        days = int((now_ms() - int(deposit["time"])) // 86_400_000)
    max_days = int(ctx.config.value("DEPOSIT:MAX_DEPOSIT_DAYS", 25))
    end = int(deposit.get("time", now_ms())) + max_days * 86_400_000
    return {"activeCharge": int(ctx.wallet.get("totalCharge", 0)),
            "activeConsume": ctx.counter("gold_consumed"),
            "amount": int(deposit.get("amount", 0)), "depositDay": days,
            "depositEndSeconds": max(0, (end - now_ms()) // 1000)}


@route(31, 2)  # DEPOSIT {id}: CapitalConfig amount
def deposit(ctx: Context, req: dict):
    row = ctx.config.index("CapitalConfig").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-1, "bad id")
    if ctx.state.get("deposit"):
        raise GameError(-4, "has deposited")
    if int(ctx.wallet.get("totalCharge", 0)) < int(ctx.config.value("DEPOSIT:ACTIVE_CHARGE_AMOUNT", 0)):
        raise GameError(-5, "charge limit")
    ledger = ctx.ledger()
    ledger.pay_jade(int(row["amount"]), ctx.config.value("DEPOSIT:COST_TYPE"))
    ctx.state["deposit"] = {"amount": int(row["amount"]), "time": now_ms()}
    ctx.save()
    return {"costResults": ledger.costs, "depositVO": _deposit_vo(ctx)}


@route(31, 3)  # WITHDRAW: DepositRateConfig rate (percent) by days held
def withdraw(ctx: Context, req: dict):
    record = ctx.state.get("deposit")
    if not record:
        raise GameError(-7, "nothing deposited")
    days = int((now_ms() - int(record["time"])) // 86_400_000)
    if days < int(ctx.config.value("DEPOSIT:MIN_DEPOSIT_DAYS", 3)):
        raise GameError(-8, "too early")
    rate = max((int(r["rate"]) for r in ctx.config.rows("DepositRateConfig") if int(r["id"]) <= days),
               default=100)
    base = int(record["amount"])
    total = base * rate // 100
    ledger = ctx.ledger()
    ledger.grant({"type": "CURRENCY", "code": 1, "amount": total})
    ctx.state.pop("deposit")
    ctx.save()
    return {"baseMoney": base, "depositVO": _deposit_vo(ctx), "income": total - base,
            "rewardResults": ledger.rewards}
