"""MsgMenpai (mod 47): 门派 with bot members.

Joining a bot sect is accepted at once; creating one costs
MENPAI:CREATE_COST_XIANYU_COUNT jade.  Donations follow the in-game rule
"每捐献1仙玉可获得1点战功，200元宝，10点贡献" (sect exp/funds + personal
MENPAI_MONEY); 祈福 uses LevelConfig.prayCost/prayReward; the shop is
GoodsSetting; sect demogs are DemogConfig MENPAI_*; 国战 (country fight) is
fought against a bot sect.  Bot activity levels are 推测值.
"""

from __future__ import annotations

import random
import time

from ..bots import BOT_BASE, bot
from ..combat import BOSS, MAJOR, MINOR, fight, make_fighter
from ..defaults import long_id
from ..settings import setting
from ..game import Context, GameError, as_id, now_ms, parse_json, route

NOT_JOIN = -8
NO_AUTH = -10
NAME_EXISTS = -12
MONEY_NOT_ENOUGH = -74
EXCHANGE_TIME_LIMIT = -77
INVALID_GOODS = -76
QUIT_COOLTIME = -82
SECT_BASE = 70_000_000
JOBS = ["BOSS", "ELDER", "MEMBER", "STRANGE"]


def _today() -> str:
    return time.strftime("%Y%m%d")


def _bot_sect(ctx: Context, sect_id: int) -> dict:
    rng = random.Random(sect_id)
    boss = bot(ctx.config, BOT_BASE + sect_id % 1_000_000, rng.randint(30, 90))
    level = rng.randint(1, 6)
    size = int(ctx.config.index("MenpaiLevelConfig").get(level, {}).get("count") or 30)
    members = [BOT_BASE + rng.randrange(1, 9_000_000) for _ in range(rng.randint(8, size - 5))]
    return {"id": sect_id, "name": boss.name[:2] + rng.choice(["门", "派", "宗", "阁", "盟"]),
            "level": level, "exp": int(ctx.config.index("MenpaiLevelConfig").get(level, {}).get("needExp") or 0),
            "money": rng.randint(10_000, 200_000), "declaration": "欢迎各位道友加入！",
            "post": "", "boss": boss.id, "boss_name": boss.name, "members": members,
            "created": now_ms() - rng.randint(1, 300) * 86_400_000}


def _sect(ctx: Context, required: bool = True) -> dict | None:
    sect = ctx.state.get("menpai")
    if sect is None and required:
        raise GameError(NOT_JOIN, "not in a sect")
    return sect


def _level_row(ctx: Context, level: int) -> dict:
    return ctx.config.index("MenpaiLevelConfig").get(int(level), {})


def _add_exp(ctx: Context, sect: dict, exp: int) -> None:
    sect["exp"] = int(sect["exp"]) + exp
    while _level_row(ctx, int(sect["level"]) + 1) and \
            sect["exp"] >= int(_level_row(ctx, int(sect["level"]) + 1)["needExp"]):
        sect["level"] = int(sect["level"]) + 1


def _info_vo(ctx: Context, sect: dict) -> dict:
    pray = sect.get("pray", {})
    return {"aplypNum": len(sect.get("applys", [])), "bossName": sect["boss_name"],
            "canPrayTime": max(0, len(parse_json(ctx.config.levels.get(ctx.level, {}).get("prayCost"), []))
                               - int(pray.get("times", 0) if pray.get("day") == _today() else 0)),
            "count": len(sect["members"]) + 1, "declaration": sect["declaration"],
            "endGrabRight": 0, "exp": int(sect["exp"]), "hasGrabed": False, "holdRewardDate": 0,
            "id": long_id(int(sect["id"])), "job": JOBS.index(sect.get("job", "MEMBER")),
            "joinBidDate": [], "joinFightDate": [], "level": int(sect["level"]),
            "money": int(sect["money"]), "name": sect["name"], "post": sect.get("post", ""),
            "prayTimes": int(pray.get("times", 0)) if pray.get("day") == _today() else 0,
            "reportDate": []}


def _apply_vo(ctx: Context, sect: dict, state: int) -> dict:
    return {"bossName": sect["boss_name"], "count": len(sect["members"]) + 1,
            "createTime": int(sect["created"]), "declaration": sect["declaration"],
            "exp": int(sect["exp"]), "id": long_id(int(sect["id"])), "joinState": state,
            "level": int(sect["level"]), "maxCount": int(_level_row(ctx, sect["level"]).get("count") or 30),
            "name": sect["name"], "rank": 0, "todayBid": 0, "yesterdayBid": 0}


@route(47, 2)  # GET_SELEF_MENPAI
def get_self(ctx: Context, req: dict):
    sect = _sect(ctx, required=False)
    if sect is None:
        raise GameError(NOT_JOIN, "not joined")
    return _info_vo(ctx, sect)


@route(47, 3)  # GET_MENPAI_LIST {key, page}
def menpai_list(ctx: Context, req: dict):
    page, size = max(1, int(req.get("page") or 1)), int(ctx.config.value("MENPAI:LIST_PAGE_SIZE", 10))
    key = str(req.get("key") or "")
    sects = [_bot_sect(ctx, SECT_BASE + i) for i in range(1, 31)]
    if key:
        sects = [s for s in sects if key in s["name"]]
    rows = sects[(page - 1) * size: page * size]
    return {"count": len(sects), "data": [_apply_vo(ctx, s, 0) for s in rows], "firstBid": 0,
            "firstMenpai": long_id(0), "ownBid": 0, "page": page, "size": size}


def _join(ctx: Context, sect: dict, job: str) -> None:
    quit_at = int(ctx.state.get("menpai_quit", 0))
    if now_ms() - quit_at < int(ctx.config.value("MENPAI:QUIT_COOLTIME", 1440)) * 60_000:
        raise GameError(QUIT_COOLTIME, "rejoin cool time")
    lock = ctx.config.index("Lock").get("MENPAI", {})
    if ctx.level < int(lock.get("level") or 0):
        raise GameError(-3, "level")
    sect.update(job=job, contribute=0, messages=[], joined=now_ms())
    ctx.state["menpai"] = sect
    ctx.save()


@route(47, 1)  # JOIN_MENPAI {menpai}: bot sects accept immediately
def join(ctx: Context, req: dict):
    if _sect(ctx, required=False):
        raise GameError(-9, "already in a sect")
    sect_id = as_id(req.get("menpai"))
    sect = _bot_sect(ctx, sect_id)
    _join(ctx, sect, "MEMBER")
    return _apply_vo(ctx, sect, 3)


@route(47, 34)  # CANCEL_APPLY
def cancel_apply(ctx: Context, req: dict):
    return _apply_vo(ctx, _bot_sect(ctx, as_id(req.get("menpai"))), 0)


@route(47, 17)  # CREATE_MENPAI {name}
def create(ctx: Context, req: dict):
    if _sect(ctx, required=False):
        raise GameError(-9, "already in a sect")
    name = str(req.get("name") or "").strip()
    if not 1 <= len(name) <= int(ctx.config.value("MENPAI:NAME_MAX_LENGTH", 12)):
        raise GameError(-11, "invalid name")
    ledger = ctx.ledger()
    ledger.pay_jade(int(ctx.config.value("MENPAI:CREATE_COST_XIANYU_COUNT", 500)),
                    ctx.config.value("MENPAI:CREATE_COST_XIANYU"))
    sect = {"id": SECT_BASE + ctx.player_id, "name": name, "level": 1, "exp": 0, "money": 0,
            "declaration": "", "post": "", "boss": ctx.player_id, "boss_name": ctx.record.role_name,
            "members": [BOT_BASE + random.randrange(1, 9_000_000) for _ in range(5)],
            "created": now_ms()}
    _join(ctx, sect, "BOSS")
    return ledger.costs


def _members(ctx: Context, sect: dict) -> list[dict]:
    rows = []
    me_card = ctx.cards[0]
    rows.append({"artifactLevel": 0, "baseId": int(me_card["base_id"]),
                 "contribute": int(sect.get("contribute", 0)), "cultivateVo": None, "equips": [],
                 "fightScore": 0, "job": JOBS.index(sect.get("job", "MEMBER")), "lastLogin": now_ms(),
                 "level": ctx.level, "name": ctx.record.role_name, "online": True,
                 "playerId": long_id(ctx.player_id), "skill": 0, "taiTalismans": [], "userBuffs": []})
    for index, mid in enumerate(sect["members"]):
        b = bot(ctx.config, mid)
        job = "BOSS" if mid == sect.get("boss") else ("ELDER" if index < int(_level_row(ctx, sect["level"]).get("elderCount") or 1) else "MEMBER")
        rows.append({"artifactLevel": 0, "baseId": b.leader, "contribute": (mid % 5000),
                     "cultivateVo": None, "equips": [], "fightScore": b.power(ctx.config),
                     "job": JOBS.index(job), "lastLogin": now_ms() - (mid % 72) * 3_600_000,
                     "level": b.level, "name": b.name, "online": mid % 3 == 0,
                     "playerId": long_id(mid), "skill": 0, "taiTalismans": [], "userBuffs": []})
    return rows


def _page(items: list, page: int, size: int) -> dict:
    page = max(1, int(page or 1))
    return {"count": len(items), "data": items[(page - 1) * size: page * size], "page": page, "size": size}


@route(47, 4)  # GET_PARTNER_LIST {page}
def partner_list(ctx: Context, req: dict):
    return _page(_members(ctx, _sect(ctx)), req.get("page"), int(ctx.config.value("MENPAI:PARTNER_PAGE_SIZE", 10)))


@route(47, 32)  # SINGLE_PARTNER {partnerId}
def single_partner(ctx: Context, req: dict):
    pid = as_id(req.get("partnerId"))
    for row in _members(ctx, _sect(ctx)):
        if as_id(row["playerId"]) == pid:
            return row
    raise GameError(-2, "partner not found")


def _require_job(sect: dict, *jobs: str) -> None:
    if sect.get("job") not in jobs:
        raise GameError(NO_AUTH, "no authority")


@route(47, 5)  # INVITE_PARTNER {partner}
def invite(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS", "ELDER")
    pid = as_id(req.get("partner"))
    if len(sect["members"]) + 1 >= int(_level_row(ctx, sect["level"]).get("count") or 30):
        raise GameError(-13, "sect full")
    if pid not in sect["members"]:
        sect["members"].append(pid)
    ctx.save()
    return 3  # JOINED


@route(47, 6)  # LIST_APPLY_USER {page}
def list_apply(ctx: Context, req: dict):
    sect = _sect(ctx)
    applys = sect.setdefault("applys", [])
    if sect.get("apply_day") != _today():
        sect["apply_day"] = _today()
        applys.extend(BOT_BASE + random.randrange(1, 9_000_000) for _ in range(2))
        del applys[:-int(ctx.config.value("MENPAI:MAX_APPLY_COUNT", 5))]
        ctx.save()
    users = []
    for aid in applys:
        b = bot(ctx.config, aid)
        users.append({"baseId": b.leader, "fightScore": b.power(ctx.config), "level": b.level,
                      "name": b.name, "playerId": long_id(aid), "skill": 0})
    return _page(users, req.get("page"), int(ctx.config.value("MENPAI:CHECK_APPLY_PAGE_SIZE", 10)))


@route(47, 7)  # CHECK_USER {accept, applyId}
def check_user(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS", "ELDER")
    aid = as_id(req.get("applyId"))
    applys = sect.setdefault("applys", [])
    if aid in applys:
        applys.remove(aid)
        if req.get("accept"):
            sect["members"].append(aid)
    ctx.save()
    return 0


@route(47, 8)  # LIST_INVITE_MENPAI {page}: bot sects invite a sect-less player
def list_invites(ctx: Context, req: dict):
    if _sect(ctx, required=False):
        return _page([], req.get("page"), 10)
    rows = []
    for i in range(1, 4):
        sect = _bot_sect(ctx, SECT_BASE + 100 + i)
        b = bot(ctx.config, sect["boss"])
        rows.append({"count": len(sect["members"]) + 1, "declaration": sect["declaration"],
                     "exp": int(sect["exp"]), "id": long_id(sect["id"]), "inviteBaseId": long_id(b.leader),
                     "inviteId": long_id(sect["id"]), "inviteJob": 0, "inviteName": b.name,
                     "joinState": 2, "level": int(sect["level"]),
                     "maxCount": int(_level_row(ctx, sect["level"]).get("count") or 30),
                     "name": sect["name"]})
    return _page(rows, req.get("page"), int(ctx.config.value("MENPAI:CHECK_INVITE_PAGE_SIZE", 10)))


@route(47, 9)  # CHECK_INVITE_MENPAI {accept, inivteId}
def check_invite(ctx: Context, req: dict):
    sect = _bot_sect(ctx, as_id(req.get("inivteId")))
    if req.get("accept"):
        _join(ctx, sect, "MEMBER")
    return _info_vo(ctx, sect)


@route(47, 10)  # CHANGE_POST {post}
def change_post(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS", "ELDER")
    sect["post"] = str(req.get("post") or "")[:int(ctx.config.value("MENPAI:POST_WORD_LIMIT", 80))]
    ctx.save()
    return 0


@route(47, 13)  # UPDATE_DECLARATION
def update_declaration(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS", "ELDER")
    sect["declaration"] = str(req.get("declaration") or "")[:int(ctx.config.value("MENPAI:MENPAI_DECLARATION_COUNT_LIMIT", 20))]
    ctx.save()
    return 0


@route(47, 44)  # MENPAI_RENAME
def rename(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS")
    sect["name"] = str(req.get("name") or sect["name"])[:12]
    ctx.save()
    return 0


@route(47, 11)  # GIVE_MESSAGE {message}
def give_message(ctx: Context, req: dict):
    sect = _sect(ctx)
    text = str(req.get("message") or "")
    if not text or len(text) > int(ctx.config.value("MENPAI:MESSAGE_WORD_LIMIT", 72)):
        raise GameError(-14, "invalid message")
    messages = sect.setdefault("messages", [])
    messages.insert(0, {"name": ctx.record.role_name, "text": text, "date": now_ms(),
                        "pid": ctx.player_id, "base": int(ctx.cards[0]["base_id"]), "level": ctx.level})
    del messages[int(ctx.config.value("MENPAI:MESSAGE_COUNT_LIMIT", 100)):]
    ctx.save()
    return 0


@route(47, 12)  # LIST_MESSAGE {page}
def list_message(ctx: Context, req: dict):
    rows = [{"baseId": m["base"], "date": m["date"], "level": m["level"], "message": m["text"],
             "name": m["name"], "playerId": long_id(m["pid"]), "skill": 0}
            for m in _sect(ctx).get("messages", [])]
    return _page(rows, req.get("page"), int(ctx.config.value("MENPAI:MESSAGE_PAGE_SIZE", 10)))


@route(47, 14)  # CONTRIBUTE_MENPAI {count}: 捐献仙玉
def contribute(ctx: Context, req: dict):
    sect = _sect(ctx)
    count = int(req.get("count") or 0)
    if count <= 0:
        raise GameError(-1, "count")
    ledger = ctx.ledger()
    ledger.pay_jade(count, ctx.config.value("MENPAI:MENPAI_EXP_COST_TYPE"))
    exp = count * int(ctx.config.value("MENPAI:MENPAI_EXP_COUNT", 10))
    _add_exp(ctx, sect, exp)
    sect["money"] = int(sect["money"]) + count * int(ctx.config.value("MENPAI:EXP2MONEY", 1)) * 10
    sect["contribute"] = int(sect.get("contribute", 0)) + exp
    ledger.grant({"type": "CURRENCY", "code": 12, "amount": count})        # 战功 (EXPLOIT)
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": count * 200})   # 元宝
    ledger.grant({"type": "MENPAI_MONEY", "code": 0, "amount": exp})       # 贡献
    ctx.save()
    return {"costReward": ledger.cost_and_reward(), "exp": int(sect["exp"]),
            "money": int(sect["money"]), "rewardExp": exp}


@route(47, 23)  # PRAY {time}: 祈福 (LevelConfig.prayCost / prayReward)
def pray(ctx: Context, req: dict):
    sect = _sect(ctx)
    row = ctx.config.levels.get(ctx.level, {})
    costs, rewards = parse_json(row.get("prayCost"), [0]), parse_json(row.get("prayReward"), [0])
    record = sect.setdefault("pray", {})
    if record.get("day") != _today():
        record.update(day=_today(), times=0)
    times = int(record["times"])
    if times >= len(costs):
        raise GameError(-20, "no pray left")
    ledger = ctx.ledger()
    ledger.pay_jade(int(costs[times]), ctx.config.value("MENPAI:PRAY_COST_TYPE"))
    rate = float(_level_row(ctx, sect["level"]).get("expRate") or 0)
    copper = int(rewards[min(ctx.level - 1, len(rewards) - 1)] * (1 + rate))
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": copper})
    record["times"] = times + 1
    ctx.save()
    return {"canPrayTime": len(costs) - record["times"], "costs": ledger.costs,
            "prayTime": record["times"], "rewards": ledger.rewards}


@route(47, 22)  # SPRING_DRINK (no content)
def spring_drink(ctx: Context, req: dict):
    return None


@route(47, 16)  # KICK_USER {player}
def kick(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS")
    pid = as_id(req.get("player"))
    if pid in sect["members"]:
        sect["members"].remove(pid)
    ctx.save()
    return 0


@route(47, 18)  # SET_MEMBER_JOB {jobType, partner}
def set_job(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS")
    jobs = sect.setdefault("jobs", {})
    jobs[str(as_id(req.get("partner")))] = str(req.get("jobType") or "MEMBER")
    ctx.save()
    return 0


@route(47, 19)  # TRANSFER_BOSS {partner}
def transfer_boss(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS")
    pid = as_id(req.get("partner"))
    if pid not in sect["members"]:
        raise GameError(-2, "not a member")
    b = bot(ctx.config, pid)
    sect.update(boss=pid, boss_name=b.name, job="ELDER")
    ctx.save()
    return 0


def _leave(ctx: Context) -> None:
    ctx.state.pop("menpai", None)
    ctx.state["menpai_quit"] = now_ms()
    ctx.save()


@route(47, 26)  # QUIT_MENPAI
def quit_menpai(ctx: Context, req: dict):
    sect = _sect(ctx)
    if sect.get("job") == "BOSS" and sect["members"]:
        raise GameError(NO_AUTH, "transfer the sect first")
    _leave(ctx)
    return 0


@route(47, 33)  # DISBAND_MENPAI
def disband(ctx: Context, req: dict):
    _require_job(_sect(ctx), "BOSS")
    _leave(ctx)
    return None


@route(47, 20)  # GRAB_TIGHT (抢夺权) — date the right lasts until
def grab_right(ctx: Context, req: dict):
    _sect(ctx)
    return now_ms() + int(ctx.config.value("MENPAI:MENPAI_PUBLIC_GRAB_BOSS_TIME", 48)) * 3_600_000


@route(47, 21)  # STOP_GRAB_RIGHT
def stop_grab(ctx: Context, req: dict):
    _require_job(_sect(ctx), "BOSS")
    return 0


# ---------------------------------------------------------------- shop
@route(47, 40)  # GET_GOODS
def get_goods(ctx: Context, req: dict):
    sect = _sect(ctx)
    used = sect.setdefault("goods", {})
    goods = [{"exchange": int(row["exchange"]) - int(used.get(str(row["id"]), 0)), "id": int(row["id"])}
             for row in ctx.config.rows("GoodsSetting") if int(row.get("playerLevel") or 0) <= ctx.level]
    return {"goods": goods, "id": long_id(int(sect["id"])), "money": ctx.counter("reward_MENPAI_MONEY_0")}


@route(47, 41)  # EXCHAGE_GOODS {goods, times}
def exchange_goods(ctx: Context, req: dict):
    sect = _sect(ctx)
    row = ctx.config.index("GoodsSetting").get(int(req.get("goods") or 0))
    if row is None or int(row.get("playerLevel") or 0) > ctx.level:
        raise GameError(INVALID_GOODS, "goods")
    times = max(1, int(req.get("times") or 1))
    used = sect.setdefault("goods", {})
    if int(used.get(str(row["id"]), 0)) + times > int(row["exchange"]):
        raise GameError(EXCHANGE_TIME_LIMIT, "limit")
    cost = int(row["need"]) * times
    if ctx.counter("reward_MENPAI_MONEY_0") < cost:
        raise GameError(MONEY_NOT_ENOUGH, "contribution")
    ctx.add_counter("reward_MENPAI_MONEY_0", -cost)
    ledger = ctx.ledger()
    ledger.costs.append({"type": 8, "code": 0, "amount": -cost, "contents": None})  # MENPAI_MONEY
    from .player import show_spec
    for _ in range(times):
        ledger.grant(show_spec(row["showType"], row["showId"], row["amount"]))
    used[str(row["id"])] = int(used.get(str(row["id"]), 0)) + times
    ctx.save()
    return ledger.cost_and_reward()


# --------------------------------------------------------- sect demogs
def _sect_demogs(sect: dict) -> list:
    return sect.setdefault("demogs", [])


@route(47, 27)  # SUMMON_DEMOG {cost}: DemogConfig MENPAI_<level>
def summon_demog(ctx: Context, req: dict):
    sect = _sect(ctx)
    row = ctx.config.index("DemogConfig").get(f"MENPAI_{int(sect['level']):03d}") or \
        ctx.config.rows("DemogConfig")[0]
    cost = int(as_id(req.get("cost")) or 0)
    if int(sect["money"]) < cost:
        raise GameError(MONEY_NOT_ENOUGH, "sect funds")
    sect["money"] = int(sect["money"]) - cost
    boss = make_fighter(ctx.config, 6, int(row["baseId"]), int(row["demogLevel"]), BOSS)
    hp = boss.max_hp * int(setting("menpai.demog_hp_factor", 40))
    demog = {"id": int(sect.get("next_demog", 1)), "config": row["id"], "base": int(row["baseId"]),
             "level": int(row["demogLevel"]), "hp": hp, "total": hp,
             "escape": now_ms() + 24 * 3_600_000, "rewarded": False}
    sect["next_demog"] = demog["id"] + 1
    _sect_demogs(sect).append(demog)
    ctx.save()
    return {"baseId": demog["base"], "costAndReward": ctx.ledger().cost_and_reward(),
            "currencyHp": hp, "demogId": long_id(demog["id"]), "escapeTime": demog["escape"],
            "totalHp": hp}


@route(47, 28)  # LIST_DEMOG {page}
def list_demog(ctx: Context, req: dict):
    sect = _sect(ctx)
    rows = [{"canReward": d["hp"] <= 0 and not d["rewarded"], "configId": d["config"],
             "demogId": long_id(d["id"]), "escapeTime": d["escape"], "hp": int(d["hp"]),
             "nameCall": sect["name"], "totalHp": int(d["total"])} for d in _sect_demogs(sect)
            if d["escape"] > now_ms() or d["hp"] <= 0]
    page = _page(rows, req.get("page"), int(ctx.config.value("MENPAI:DEMOG_PAGE_SIZE", 10)))
    page["attackCooltime"] = int(sect.get("attack_cool", 0))
    return page


def _demog(sect: dict, demog_id) -> dict:
    did = as_id(demog_id)
    for d in _sect_demogs(sect):
        if int(d["id"]) == did:
            return d
    raise GameError(-2, "demog not found")


@route(47, 30)  # ATTACK_DEMOG {demogId, embattle}
def attack_demog(ctx: Context, req: dict):
    sect = _sect(ctx)
    if int(sect.get("attack_cool", 0)) > now_ms():
        raise GameError(-16, "cool time")
    d = _demog(sect, req.get("demogId"))
    if d["hp"] <= 0:
        raise GameError(-6, "already killed")
    from .battle import card_fighter
    boss = make_fighter(ctx.config, 6, d["base"], d["level"], BOSS)
    boss.hp, boss.max_hp = int(d["hp"]), int(d["total"])
    reports, damage = [], 0
    for grid in req.get("embattle") or []:
        team = []
        for r, row in enumerate(grid):
            for c, value in enumerate(row):
                card = ctx.card(as_id(value)) if as_id(value) else None
                if card:
                    team.append(card_fighter(ctx, r * 2 + c, card, MAJOR if not team else MINOR))
        if team:
            before = boss.hp
            _, report = fight(ctx.config, team, [boss])
            reports.append(report)
            damage += before - boss.hp
    if not reports:
        raise GameError(-1, "empty formation")
    d["hp"] = max(0, boss.hp)
    sect["attack_cool"] = now_ms() + int(ctx.config.value("MENPAI:ATTACK_COOLTIME", 360)) * 1000
    ledger = ctx.ledger()
    # MENPAI:ATTACK_REWARD_COUNT = ceil(damage^0.25)*300+2000 copper
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": int(-(-damage ** 0.25 // 1)) * 300 + 2000})
    ctx.save()
    return {"currenttHp": int(d["hp"]), "demage": damage, "groupNum": len(reports),
            "reports": reports, "rewardResult": ledger.rewards, "totalHp": int(d["total"]),
            "win": d["hp"] <= 0}


@route(47, 29)  # CLEAR_COOLTIME
def clear_cool(ctx: Context, req: dict):
    sect = _sect(ctx)
    ledger = ctx.ledger()
    if int(sect.get("attack_cool", 0)) > now_ms():
        ledger.pay_jade(int(ctx.config.value("MENPAI:CLEAR_COOLTIME_COUNT", 10)),
                        ctx.config.value("MENPAI:CLEAR_ATTACK_COOLTIME_COST"))
        sect["attack_cool"] = 0
        ctx.save()
    return ledger.costs


@route(47, 31)  # DRAW_REWARD {demogId}
def draw_demog_reward(ctx: Context, req: dict):
    sect = _sect(ctx)
    d = _demog(sect, req.get("demogId"))
    if d["hp"] > 0 or d["rewarded"]:
        raise GameError(-7, "cannot draw")
    row = ctx.config.index("DemogConfig").get(d["config"], {})
    ledger = ctx.ledger()
    from .player import show_spec
    for kind, show_id, amount in zip(parse_json(row.get("showTypeId"), []),
                                     parse_json(row.get("showIds"), []),
                                     parse_json(row.get("counts"), [])):
        if kind == "GOLDCARD":
            ledger.grant({"type": "CURRENCY", "code": 1, "amount": 100 * int(amount)})  # 推测值
        else:
            ledger.grant(show_spec(kind, show_id, amount))
    d["rewarded"] = True
    ctx.save()
    return ledger.rewards


# ------------------------------------------------------------ 国战
@route(47, 35)  # COUNTRY_DATA
def country_data(ctx: Context, req: dict):
    sect = _sect(ctx)
    held = sect.get("country")
    datas = [{"data": {"id": int(c["id"]), "holder": sect["name"] if held == c["id"] else ""},
              "state": 4 if held == c["id"] else 0} for c in ctx.config.rows("CountrySetting")]
    return {"countryDatas": datas, "ownData": {"bid": int(sect.get("bid", 0)), "country": held or 0},
            "state": 4 if held else 0}


@route(47, 37)  # BID_FOR_COUNTRY {count, country}
def bid_country(ctx: Context, req: dict):
    sect = _sect(ctx)
    _require_job(sect, "BOSS")
    row = ctx.config.index("CountrySetting").get(int(req.get("country") or 0))
    count = int(req.get("count") or 0)
    if row is None:
        raise GameError(-79, "invalid country")
    if count < int(row["minBid"]) or count > int(sect["money"]):
        raise GameError(MONEY_NOT_ENOUGH, "bid")
    sect["money"] = int(sect["money"]) - count
    sect["bid"] = int(sect.get("bid", 0)) + count
    sect["bid_country"] = int(row["id"])
    ctx.save()
    return {"bid": count, "currentMoney": int(sect["money"]), "totalBid": int(sect["bid"])}


@route(47, 15)  # BID_RANK {count}: bid for boss-grab rank; returns bid total
def bid_rank(ctx: Context, req: dict):
    sect = _sect(ctx)
    count = int(req.get("count") or 0)
    ledger = ctx.ledger()
    ledger.pay_jade(count, ctx.config.value("MENPAI:MENPAI_BID_COST_TYPE"))
    sect["rank_bid"] = int(sect.get("rank_bid", 0)) + count
    ctx.save()
    return float(sect["rank_bid"])


def _joined_vo(ctx: Context, sect: dict, country: int, joined: bool) -> dict:
    enemy = _bot_sect(ctx, SECT_BASE + 900 + country)
    return {"country": country, "joined": joined, "ownMenpaiId": long_id(int(sect["id"])),
            "ownMenpaiName": sect["name"], "ownTeam": _members(ctx, sect)[:3],
            "targetMenpaiId": long_id(int(enemy["id"])), "targetMenpaiName": enemy["name"],
            "targetTeam": []}


@route(47, 38)  # COUNTRY_FIGHT_JOINED {country, join}
def fight_joined(ctx: Context, req: dict):
    sect = _sect(ctx)
    country = int(req.get("country") or 0)
    sect["fight_joined"] = bool(req.get("join"))
    ctx.save()
    return _joined_vo(ctx, sect, country, sect["fight_joined"])


@route(47, 43)  # QUIT_COUNTRY_FIGHT
def quit_fight(ctx: Context, req: dict):
    sect = _sect(ctx)
    sect["fight_joined"] = False
    ctx.save()
    return _joined_vo(ctx, sect, int(sect.get("bid_country", 0)), False)


@route(47, 39)  # COUNTRY_FIGHT_RESULT {country}: resolve against a bot sect
def fight_result(ctx: Context, req: dict):
    sect = _sect(ctx)
    country = int(req.get("country") or sect.get("bid_country") or 0)
    if not sect.get("fight_joined") or sect.get("bid_country") != country:
        raise GameError(-78, "not joined")
    enemy = _bot_sect(ctx, SECT_BASE + 900 + country)
    from .arena import my_power
    won = my_power(ctx) * (1 + len(sect["members"]) / 30) >= random.randint(500, 3000)  # 推测值
    if won:
        sect["country"] = country
    sect["fight_joined"] = False
    ctx.save()
    record = {"demage": [], "fighers": [long_id(ctx.player_id)], "originalHp": [],
              "roundDemage": [], "startHp": [], "winCount": {}, "won": 0 if won else 1}
    return {"fightJoinedVo": _joined_vo(ctx, sect, country, False), "fightReport": [[record]],
            "winMenpaiId": long_id(int(sect["id"] if won else enemy["id"]))}
