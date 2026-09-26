"""Remaining account (10), gift (16), target (28), platform (30), system (0) commands."""

from __future__ import annotations

import hashlib
import random
import time

from ..game import Context, GameError, route
from ..storage import InvalidRoleError, validate_role_name


def _today() -> str:
    return time.strftime("%Y%m%d")


# --------------------------------------------------------------- account
@route(10, 3)  # RELOGIN
def relogin(ctx: Context, req: dict):
    return 0


@route(10, 5)  # CHECK_FATIGUE_STATE (anti-addiction; disabled offline)
def fatigue(ctx: Context, req: dict):
    return None


@route(10, 6)  # UPDATE_INCOME_RATE
def income_rate(ctx: Context, req: dict):
    return None


@route(10, 8)  # RENAME {name}
def rename(ctx: Context, req: dict):
    name = str(req.get("name") or "")
    try:
        validate_role_name(name)
        ctx.server.repository.rename(ctx.account, name)
    except InvalidRoleError as error:
        raise GameError(-3, str(error)) from error
    except ValueError as error:
        raise GameError(-4, "name exists") from error
    return 0


@route(10, 10)  # UPDATE_PUSH {push}
def update_push(ctx: Context, req: dict):
    ctx.state["push"] = bool(req.get("push"))
    ctx.save()
    return 0


@route(10, 11)  # PUSH_STATE
def push_state(ctx: Context, req: dict):
    return bool(ctx.state.get("push", True))


# ------------------------------------------------------------------ gift
@route(16, 6)  # SP_RECORD
def sp_record(ctx: Context, req: dict):
    return {"comment": int(bool(ctx.state.get("sp_comment"))), "register": 1}


@route(16, 8)  # DRAW_SP_COMMENT: GIFT:SP_COMMENT_REWARD once
def sp_comment(ctx: Context, req: dict):
    if ctx.state.get("sp_comment"):
        raise GameError(-5, "received")
    ctx.ledger().grant_reward_id(ctx.config.value("GIFT:SP_COMMENT_REWARD", "PL101"))
    ctx.state["sp_comment"] = True
    ctx.save()
    return {"comment": 1, "register": 1}


@route(16, 2)  # DRAW_GLOBAL {giftId}: global gifts are part of the activity list
def draw_global(ctx: Context, req: dict):
    from .activity import draw_global_gift
    return draw_global_gift(ctx, str(req.get("giftId") or ""))


@route(16, 10)  # DRAW_ACTIVITY {activity, giftId}
def draw_activity(ctx: Context, req: dict):
    from .activity import draw_global_gift
    return draw_global_gift(ctx, str(req.get("giftId") or ""))


@route(16, 3)  # DRAW_SERIAL {serial, signal}: 礼包码 — no code server offline
def draw_serial(ctx: Context, req: dict):
    raise GameError(-12, "serial not found")


@route(16, 12)  # CLAIM_PROGRESS {category, threshold}: no progress tiers are defined
def claim_progress(ctx: Context, req: dict):
    raise GameError(-1, "gift not found")


# ---------------------------------------------------------------- target
@route(28, 2)  # GET_PROGRESS {type}
def target_progress(ctx: Context, req: dict):
    return {"CONSUME": float(ctx.counter("gold_consumed")),
            "CHARGE": float(ctx.wallet.get("totalCharge", 0))}


@route(28, 1)  # EXCHANGE {id}: TARGET:OPEN_CHARGE_AMOUNT gate; no target table shipped
def target_exchange(ctx: Context, req: dict):
    raise GameError(-2, "target not open")


# -------------------------------------------------------------- platform
@route(30, 1)  # DRAW_PRAISE_REWARD (store rating reward, once)
def praise(ctx: Context, req: dict):
    if ctx.state.get("praised"):
        raise GameError(-1, "drawn")
    ctx.ledger().grant_reward_id(ctx.config.value("PLATFORM:PRASE_REWARD_ID", ""))
    ctx.state["praised"] = True
    ctx.save()
    return 0


@route(30, 2)  # INITIATIVE_SHARE
def share(ctx: Context, req: dict):
    record = ctx.state.setdefault("share", {})
    if record.get("day") == _today():
        raise GameError(-2, "shared today")
    record["day"] = _today()
    record["times"] = int(record.get("times", 0)) + int(ctx.config.value("PLATFORM:EACH_SHARE_LOTTERY_TIMES", 1))
    ctx.save()
    return {"lotteryTimes": int(record["times"]), "rewardResults": []}


@route(30, 3)  # PASSIVE_SHARE
def passive_share(ctx: Context, req: dict):
    return 0


@route(30, 4)  # GET_COMMON_INFO (微信转盘)
def roulette_info(ctx: Context, req: dict):
    return {"common": [], "fcode": [], "lotteryTimes": int(ctx.state.get("share", {}).get("times", 0))}


@route(30, 5)  # ROULETTE: WechatRoulette table
def wechat_roulette(ctx: Context, req: dict):
    record = ctx.state.setdefault("share", {})
    if int(record.get("times", 0)) <= 0:
        raise GameError(-6, "no times")
    rows = ctx.config.rows("WechatRoulette")
    if not rows:
        raise GameError(-7, "closed")
    row = random.choice(rows)
    record["times"] = int(record["times"]) - 1
    ledger = ctx.ledger()
    reward = row.get("rewardId") or row.get("reward")
    if reward:
        ledger.grant_reward_id(reward)
    ctx.save()
    return {"id": int(row["id"]), "rewardResults": ledger.rewards}


# ---------------------------------------------------------------- system
@route(0, 3)  # MD5_DESCRIPTION: protocol description hash (client keeps its own copy)
def md5_description(ctx: Context, req: dict):
    return hashlib.md5(b"hakimi-local").hexdigest()


@route(0, 1)  # REQUEST_DESCRIPTION
def request_description(ctx: Context, req: dict):
    return b""
