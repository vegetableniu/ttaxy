"""MsgEmail (mod 17): mailbox, system mails with attachments, player mail.

Other modules call :func:`send_system_mail` (MailTemplate id + reward specs).
Player-to-player mail is delivered to other local accounts by role name.
"""

from __future__ import annotations

from ..game import Context, GameError, now_ms, route

RECEIVER_NOT_FOUND = -2
CANNOT_SENT_OWN = -3
INVALID_TITLE = -4
INVALID_CONTENT = -5
OUT_OF_LIMIT = -7
ATTACHMENT_DRAW = -12
EMAIL_NOT_FOUND = -15
KEEP_DAYS = 30


def _mails(state: dict) -> list[dict]:
    return state.setdefault("mails", [])


def _new_mail(state: dict, **fields) -> dict:
    mail_id = int(state.get("next_mail_id", 0)) + 1
    state["next_mail_id"] = mail_id
    mail = {"id": mail_id, "created": now_ms(), "read": False, "drawed": False,
            "template": 0, "title": "", "content": "", "sender": "系统", "sender_id": 0,
            "system": True, "rewards": [], "type": 1}
    mail.update(fields)
    _mails(state).insert(0, mail)
    return mail


def send_system_mail(ctx: Context, template: int, rewards: list[dict] | None = None,
                     title: str | None = None, content: str | None = None) -> dict:
    row = ctx.config.index("MailTemplate").get(int(template), {})
    mail = _new_mail(ctx.state, template=int(template),
                     title=title if title is not None else row.get("title", ""),
                     content=content if content is not None else row.get("content", ""),
                     rewards=list(rewards or []))
    ctx.save()
    return mail


def _vo(ctx: Context, mail: dict) -> dict:
    rewards = [{"type": r["type"], "code": int(r.get("code", 0)),
                "amount": int(r.get("amount", 1)), "content": ""} for r in mail["rewards"]]
    return {
        "attachment": {"charge": 0, "chargeTypes": [], "rewards": rewards} if rewards else None,
        "baseId": 0, "content": mail["content"], "createTime": int(mail["created"]),
        "destoryTime": int(mail["created"]) + KEEP_DAYS * 86_400_000,
        "drawed": bool(mail["drawed"]),
        "groupTarget": {"id": str(ctx.player_id), "type": 0},
        "id": int(mail["id"]), "mailState": 0, "mailType": int(mail.get("type", 1)),
        "readed": bool(mail["read"]), "receiver": ctx.record.role_name,
        "sender": mail["sender"], "senderId": int(mail["sender_id"]),
        "system": bool(mail["system"]), "template": int(mail["template"]),
        "title": mail["title"],
    }


def _expire(ctx: Context) -> None:
    limit = now_ms() - KEEP_DAYS * 86_400_000
    mails = _mails(ctx.state)
    kept = [m for m in mails if int(m["created"]) >= limit]
    if len(kept) != len(mails):
        mails[:] = kept
        ctx.save()


def _mail(ctx: Context, mail_id) -> dict:
    for mail in _mails(ctx.state):
        if int(mail["id"]) == int(mail_id or 0):
            return mail
    raise GameError(EMAIL_NOT_FOUND, "mail not found")


def has_new(ctx: Context) -> bool:
    return any(not m["read"] or (m["rewards"] and not m["drawed"]) for m in _mails(ctx.state))


@route(17, 1)  # GET_MAILBOX
def get_mailbox(ctx: Context, req: dict):
    _expire(ctx)
    sent = ctx.state.get("sent_mails", [])
    return {"lastSentTime": int(sent[0]["created"]) if sent else 0,
            "receives": [_vo(ctx, m) for m in _mails(ctx.state)],
            "sends": [], "sentSize": len(sent)}


def _draw(ctx: Context, mail: dict) -> None:
    if mail["drawed"]:
        raise GameError(ATTACHMENT_DRAW, "already drawn")
    ctx.ledger().grant_all(mail["rewards"])
    mail["drawed"] = mail["read"] = True
    ctx.save()


@route(17, 4)  # DRAW_USER {mailId, target}
def draw_user(ctx: Context, req: dict):
    mail = _mail(ctx, req.get("mailId"))
    if not mail["rewards"]:
        raise GameError(-8, "no attachment")
    _draw(ctx, mail)
    return ctx.ledger().rewards


@route(17, 6)  # READ_MAIL
def read_mail(ctx: Context, req: dict):
    _mail(ctx, req.get("mailId"))["read"] = True
    ctx.save()
    return True


@route(17, 7)  # REMOVE_MAIL {targets: {mailId: GroupTarget}}
def remove_mail(ctx: Context, req: dict):
    ids = {int(k) for k in (req.get("targets") or {})}
    mails = _mails(ctx.state)
    mails[:] = [m for m in mails if int(m["id"]) not in ids
                or (m["rewards"] and not m["drawed"])]  # never lose attachments
    ctx.save()
    return True


@route(17, 9)  # REMOVE_ALL_MAIL: claim every attachment, then delete
def remove_all_mail(ctx: Context, req: dict):
    ids = {int(k) for k in (req.get("targets") or {})}
    for mail in _mails(ctx.state):
        if int(mail["id"]) in ids and mail["rewards"] and not mail["drawed"]:
            _draw(ctx, mail)
    mails = _mails(ctx.state)
    mails[:] = [m for m in mails if int(m["id"]) not in ids]
    ctx.save()
    return ctx.ledger().rewards


@route(17, 8)  # HAS_NEW
def has_new_route(ctx: Context, req: dict):
    return has_new(ctx)


@route(17, 2)  # SEND_USERMAIL {content, target(role name), title}
def send_user_mail(ctx: Context, req: dict):
    title, content = str(req.get("title") or ""), str(req.get("content") or "")
    low, high = ctx.config.value("EMAIL:TITLE_LIMIT", [0, 20])
    if not low <= len(title) <= high:
        raise GameError(INVALID_TITLE, "title")
    low, high = ctx.config.value("EMAIL:CONTENT_LIMIT", [1, 500])
    if not low <= len(content) <= high:
        raise GameError(INVALID_CONTENT, "content")
    target = str(req.get("target") or "")
    if target == ctx.record.role_name:
        raise GameError(CANNOT_SENT_OWN, "own")
    sent = ctx.state.setdefault("sent_mails", [])
    if len(sent) >= int(ctx.config.value("EMAIL:SEND_TIMES", 50)):
        raise GameError(OUT_OF_LIMIT, "send limit")
    repo = ctx.server.repository
    other = repo.find_by_role(target)
    if other is None:
        raise GameError(RECEIVER_NOT_FOUND, "receiver")
    state = other.state
    _new_mail(state, title=title, content=content, sender=ctx.record.role_name,
              sender_id=ctx.player_id, system=False)
    repo.update_state(other.account, state)
    sent.insert(0, {"created": now_ms(), "target": target, "title": title})
    ctx.save()
    return True


@route(17, 3)  # SEND_GROUPMAIL (GM broadcast; not available to players)
def send_group_mail(ctx: Context, req: dict):
    return None


@route(17, 5)  # DRAW_SYSTEM (legacy no-op)
def draw_system(ctx: Context, req: dict):
    return None
