"""MsgSociality (19), MsgChat (15), MsgWorldchat (92), MsgInvite (25).

Friends are local bots (see bots.py): applications by name are accepted at
once, recommended players are bots near the player's level, and friends send
friendship points daily.  Limits come from ConfigValue SOCIALITY:* and
LevelConfig.friends.
"""

from __future__ import annotations

import random
import time

from ..bots import BOT_BASE, bot, bots_near, commend_vo, friend_vo, is_bot
from ..defaults import long_id
from ..game import Context, GameError, as_id, now_ms, route

ADD_IS_MORE = -21
ADD_IS_REPEAT = -22
TODAY_RECV_LIMIT = -24
TODAY_SEND_LIMIT = -25
GIFT_NOT_EXIST = -26
TODAY_SENDED = -27
BUY_LIMIT = -28
NOT_FOUND = -2


def _today() -> str:
    return time.strftime("%Y%m%d")


def _social(ctx: Context) -> dict:
    social = ctx.state.setdefault("social", {"friends": [], "applys": [], "extend": 0,
                                            "day": "", "sends": [], "recvs": [], "gifts": []})
    if social.get("day") != _today():
        # friends' daily gifts arrive; bots also apply now and then
        rng = random.Random(f"{ctx.player_id}:{_today()}")
        social.update(day=_today(), sends=[], recvs=[],
                      gifts=[f for f in social["friends"] if rng.random() < 0.6])
        if len(social["applys"]) < 3:
            social["applys"].append(BOT_BASE + rng.randrange(1, 9_000_000))
        ctx.save()
    return social


def _limit(ctx: Context) -> int:
    base = int(ctx.config.levels.get(ctx.level, {}).get("friends") or 10)
    return base + int(_social(ctx)["extend"]) * int(ctx.config.value("SOCIALITY:BUY_PACK_SIZE", 5))


def _friend(ctx: Context, fid: int) -> dict:
    if is_bot(fid):
        return friend_vo(ctx.config, bot(ctx.config, fid), now_ms())
    other = next((r for r in ctx.server.repository.all_accounts() if r.player_id == fid), None)
    if other is None:
        return friend_vo(ctx.config, bot(ctx.config, BOT_BASE + fid), now_ms())
    level = int(other.state.get("player", {}).get("level", 1))
    return {"artifactLevel": 0, "baseId": int(other.starter_hero), "cultivateVo": None,
            "equips": [], "heroLevel": level, "id": long_id(fid), "level": level,
            "loginOn": int(other.updated_ms), "name": other.role_name, "online": False,
            "powerSkill": 0, "pvpDesId": 0, "score": 0, "talisman": [], "userBuffs": [],
            "vip": False}


@route(19, 1)  # GET_SOCIALITY
def get_sociality(ctx: Context, req: dict):
    s = _social(ctx)
    return {"applys": [_friend(ctx, f) for f in s["applys"]],
            "extendCount": int(s["extend"]), "extendLimit": _limit(ctx),
            "friends": [_friend(ctx, f) for f in s["friends"]],
            "gifts": [long_id(f) for f in s["gifts"]],
            "recvs": [long_id(f) for f in s["recvs"]],
            "sends": [long_id(f) for f in s["sends"]]}


@route(19, 5)  # COMMEND_FRIEND
def commend_friend(ctx: Context, req: dict):
    s = _social(ctx)
    count = int(ctx.config.value("SOCIALITY:COMMEND_OTHERS", 5))
    seed = f"{ctx.player_id}:{now_ms() // 60_000}"
    return [commend_vo(ctx.config, b, b.id in s["friends"])
            for b in bots_near(ctx.config, ctx.level, count, seed)]


def _add_friend(ctx: Context, fid: int) -> None:
    s = _social(ctx)
    if fid in s["friends"]:
        raise GameError(ADD_IS_REPEAT, "already friends")
    if len(s["friends"]) >= _limit(ctx):
        raise GameError(ADD_IS_MORE, "friend list full")
    s["friends"].append(fid)
    ctx.save()


@route(19, 2)  # APPLY_FRIEND {name}: bots (and local players) accept immediately
def apply_friend(ctx: Context, req: dict):
    name = str(req.get("name") or "")
    s = _social(ctx)
    for seed in range(200):  # recently seen bots first
        candidate = bots_near(ctx.config, ctx.level, 5, f"{ctx.player_id}:{now_ms() // 60_000 - seed}")
        match = next((b for b in candidate if b.name == name), None)
        if match:
            _add_friend(ctx, match.id)
            return 0
    other = ctx.server.repository.find_by_role(name)
    if other is None or other.account == ctx.account:
        raise GameError(NOT_FOUND, "player not found")
    _add_friend(ctx, int(other.player_id))
    return 0


@route(19, 3)  # REMOVE_FRIEND
def remove_friend(ctx: Context, req: dict):
    s = _social(ctx)
    fid = as_id(req.get("friendId"))
    if fid not in s["friends"]:
        raise GameError(NOT_FOUND, "not a friend")
    s["friends"].remove(fid)
    ctx.save()
    return 0


@route(19, 4)  # APPLY_CONFIRM {allow, friendId}
def apply_confirm(ctx: Context, req: dict):
    s = _social(ctx)
    fid = as_id(req.get("friendId"))
    if fid in s["applys"]:
        s["applys"].remove(fid)
        if req.get("allow"):
            _add_friend(ctx, fid)
    ctx.save()
    return [_friend(ctx, f) for f in s["friends"]]


@route(19, 9)  # LIST_APPLYS
def list_applys(ctx: Context, req: dict):
    return [_friend(ctx, f) for f in _social(ctx)["applys"]]


@route(19, 10)  # LIST_GIFTS
def list_gifts(ctx: Context, req: dict):
    return [long_id(f) for f in _social(ctx)["gifts"]]


@route(19, 7)  # SEND_POINT {friendId}
def send_point(ctx: Context, req: dict):
    s = _social(ctx)
    fid = as_id(req.get("friendId"))
    if fid not in s["friends"]:
        raise GameError(NOT_FOUND, "not a friend")
    if fid in s["sends"]:
        raise GameError(TODAY_SENDED, "sent today")
    if len(s["sends"]) >= int(ctx.config.value("SOCIALITY:GIFT_SENDS", 999)):
        raise GameError(TODAY_SEND_LIMIT, "send limit")
    s["sends"].append(fid)
    ctx.save()
    return 0


@route(19, 8)  # RECV_POINT {friendId}
def recv_point(ctx: Context, req: dict):
    s = _social(ctx)
    fid = as_id(req.get("friendId"))
    if fid not in s["gifts"]:
        raise GameError(GIFT_NOT_EXIST, "no gift")
    if len(s["recvs"]) >= int(ctx.config.value("SOCIALITY:GIFT_RECVS", 12)):
        raise GameError(TODAY_RECV_LIMIT, "receive limit")
    s["gifts"].remove(fid)
    s["recvs"].append(fid)
    ledger = ctx.ledger()
    ledger.grant({"type": "ACTION_POINT", "code": 0,
                  "amount": int(ctx.config.value("SOCIALITY:GIFT_POINT", 5))})
    return ledger.rewards


@route(19, 11)  # ASK_FOR_POINT: friends answer with gifts
def ask_for_point(ctx: Context, req: dict):
    s = _social(ctx)
    asked = ctx.state.setdefault("social_ask", {})
    if asked.get("day") == _today():
        raise GameError(-29, "asked today")
    asked["day"] = _today()
    for fid in s["friends"]:
        if fid not in s["gifts"] and fid not in s["recvs"]:
            s["gifts"].append(fid)
    ctx.save()
    return len(s["gifts"])


@route(19, 12)  # COMAND_ASK_FOR_LIST
def ask_for_list(ctx: Context, req: dict):
    return [long_id(f) for f in _social(ctx)["friends"]]


@route(19, 6)  # BUY_PACK: more friend slots
def buy_pack(ctx: Context, req: dict):
    s = _social(ctx)
    costs = ctx.config.value("SOCIALITY:BUY_PACK_COST", [5])
    if int(s["extend"]) >= len(costs):
        raise GameError(BUY_LIMIT, "buy limit")
    ledger = ctx.ledger()
    ledger.pay_jade(int(costs[int(s["extend"])]), ctx.config.value("SOCIALITY:BUY_PACK_TYPE"))
    s["extend"] = int(s["extend"]) + 1
    ctx.save()
    return {"costs": ledger.costs, "extendCount": int(s["extend"]), "extendLimit": _limit(ctx)}


# ------------------------------------------------------------------ chat
@route(15, 1)  # GET_POSTS {time}: system notices (none locally)
def get_posts(ctx: Context, req: dict):
    return []


def _chat_messages(ctx: Context) -> list[dict]:
    return ctx.state.setdefault("world_chat", [])


BOT_LINES = ["有人一起刷副本吗？", "今天抽到了七星卡！", "求带精英副本", "门派招人，活跃的来",
             "竞技场好难打", "蟠桃在哪掉？", "新手求攻略", "大家好~"]


def _chat_vo(msg: dict) -> dict:
    return {"id": long_id(int(msg["id"])), "playerId": long_id(int(msg["pid"])),
            "name": msg["name"], "baseId": int(msg["base"]), "level": int(msg["level"]),
            "skill": 0, "message": msg["text"], "date": int(msg["date"])}


@route(92, 1)  # GET_LIST {afterId}
def world_chat_list(ctx: Context, req: dict):
    messages = _chat_messages(ctx)
    minute = now_ms() // 120_000
    last = int(ctx.state.get("chat_bot_minute", 0))
    if minute != last:  # a bot says something every couple of minutes
        rng = random.Random(minute)
        b = bot(ctx.config, BOT_BASE + rng.randrange(1, 9_000_000), max(1, ctx.level + rng.randint(-5, 5)))
        messages.append({"id": len(messages) + 1, "pid": b.id, "name": b.name, "base": b.leader,
                         "level": b.level, "text": rng.choice(BOT_LINES), "date": now_ms()})
        ctx.state["chat_bot_minute"] = minute
        del messages[:-50]
        ctx.save()
    after = int(req.get("afterId") or 0)
    return [_chat_vo(m) for m in messages if int(m["id"]) > after]


@route(92, 2)  # SEND {content}
def world_chat_send(ctx: Context, req: dict):
    text = str(req.get("content") or "").strip()
    if not text or len(text) > 60:
        raise GameError(-12, "invalid content")
    lock = ctx.config.index("Lock").get("WORLD_CHAT", {})
    if ctx.level < int(lock.get("level") or 0):
        raise GameError(-11, "level")
    messages = _chat_messages(ctx)
    cards = ctx.cards
    leader = next((c for c in cards if int(c["id"]) == int(ctx.record.hero_id)), cards[0])
    msg = {"id": (int(messages[-1]["id"]) if messages else 0) + 1, "pid": ctx.player_id,
           "name": ctx.record.role_name, "base": int(leader["base_id"]), "level": ctx.level,
           "text": text, "date": now_ms()}
    messages.append(msg)
    del messages[:-50]
    ctx.save()
    return _chat_vo(msg)


# ---------------------------------------------------------------- invite
@route(25, 2)  # REWARD_LIST
def invite_info(ctx: Context, req: dict):
    invite = ctx.state.get("invite", {})
    return {"addCode": bool(invite.get("added")), "inviteCode": f"H{ctx.player_id}",
            "inviteNum": 0, "rewardList": []}


@route(25, 1)  # CHAECK_INVITE_CODE
def check_invite(ctx: Context, req: dict):
    code = str(req.get("invite") or "")
    return code.startswith("H") and code != f"H{ctx.player_id}"


@route(25, 3)  # ADD_INVITE_CODE: another local player's code
def add_invite(ctx: Context, req: dict):
    code = str(req.get("invite") or "")
    if code == f"H{ctx.player_id}":
        raise GameError(-1, "own code")
    invite = ctx.state.setdefault("invite", {})
    if invite.get("added"):
        raise GameError(-2, "already added")
    if not code.startswith("H") or not code[1:].isdigit():
        raise GameError(-3, "invalid code")
    invite["added"] = code
    ctx.save()
    return 0
