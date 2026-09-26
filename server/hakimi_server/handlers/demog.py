"""MsgDemog (mod 26): 魔神 world bosses.

A demog appears after campaign battles (see battle.settle → maybe_spawn) or on
REFRESH_DEMOG.  Its model comes from DemogBattleConfig "<active>BN<level:03><n>".
Attacks cost DEMOG energy (action point kind 1: ATTACK_NORMAL_ENERGY /
ATTACK_ALL_OUT_ENERGY, all-out ×ALL_OUT_ATTACK_ADD); damage dealt becomes feat,
spent on FeatReward tiers; kills pay 精元 (DEMOG_FRAGMENT) for FragmentExchange.
Boss HP, feat per damage and kill rewards are 推测值.
"""

from __future__ import annotations

import random

from ..bots import BOT_BASE, bot
from ..combat import BOSS, fight, make_fighter
from ..defaults import long_id
from ..game import Context, GameError, as_id, now_ms, parse_json, point_value, refresh_points, route

NOT_FOUND = -2
ENERGY_NOT_ENOUGH = -5
ESCAPE_HOURS = 24
HP_FACTOR = 60  # 推测值: boss HP multiplier


def _active(ctx: Context) -> str:
    for row in ctx.config.rows("DemogActiveConfig"):
        low, high = (parse_json(row.get("playerLv"), [[0, 999]]) or [[0, 999]])[0]
        if low <= ctx.level <= high and row["type"] == "NORMAL":
            chosen = row["id"]
    return locals().get("chosen", "DA01")


def _demog_state(ctx: Context) -> dict:
    return ctx.state.setdefault("demog", {"list": [], "killed": [], "feat": 0, "drawn": [],
                                          "damage_max": 0, "next": 1, "exchange": {}})


def _battle_row(ctx: Context, level: int) -> tuple[str, int]:
    active = _active(ctx)
    table = ctx.config.index("DemogBattleConfig")
    for lv in range(max(1, level), 0, -1):
        options = [k for k in (f"{active}BN{lv:03d}{n}" for n in range(1, 11)) if k in table]
        if options:
            key = random.choice(options[:2])  # 推测值: mostly 普通/精英 variants
            return key, int(table[key]["baseId"])
    return f"{active}BN0011", 4502


def spawn(ctx: Context) -> dict:
    d = _demog_state(ctx)
    level = max(1, ctx.level)
    battle_id, base = _battle_row(ctx, level)
    boss = make_fighter(ctx.config, 6, base, level, BOSS)
    hp = boss.max_hp * HP_FACTOR
    demog = {"id": int(d["next"]), "battle": battle_id, "base": base, "level": level,
             "hp": hp, "total": hp, "escape": now_ms() + ESCAPE_HOURS * 3_600_000,
             "damages": {}, "attacked": False}
    d["next"] = int(d["next"]) + 1
    d["list"].append(demog)
    ctx.save()
    return demog


def maybe_spawn(ctx: Context) -> bool:
    lock = ctx.config.index("Lock").get("DEMOG", {})
    if ctx.level < int(lock.get("level") or 28):
        return False
    alive = [x for x in _demog_state(ctx)["list"] if x["escape"] > now_ms()]
    if alive or random.random() > 0.15:  # 推测值: appearance chance
        return False
    spawn(ctx)
    return True


def _vo(ctx: Context, demog: dict) -> dict:
    return {"attacked": bool(demog["attacked"]), "battleId": demog["battle"],
            "currentHp": int(demog["hp"]), "escapeTime": max(0, (demog["escape"] - now_ms()) // 1000),
            "id": long_id(int(demog["id"])), "level": int(demog["level"]),
            "summoner": long_id(ctx.player_id), "summonerName": ctx.record.role_name,
            "totalHp": int(demog["total"])}


def _find(ctx: Context, demog_id) -> dict:
    did = as_id(demog_id)
    for demog in _demog_state(ctx)["list"]:
        if int(demog["id"]) == did:
            return demog
    raise GameError(NOT_FOUND, "demog not found")


def _expire(ctx: Context) -> None:
    d = _demog_state(ctx)
    d["list"] = [x for x in d["list"] if x["escape"] > now_ms() and x["hp"] > 0]


@route(26, 12)  # GET_ACTIVE_ID
def active_id(ctx: Context, req: dict):
    return _active(ctx)


@route(26, 1)  # ACTIVE_INFO
def active_info(ctx: Context, req: dict):
    d = _demog_state(ctx)
    return {"activeId": _active(ctx), "drawReward": list(d["drawn"]), "endTime": 365 * 86400,
            "exchangeMap": {int(k): int(v) for k, v in d["exchange"].items()},
            "feat": int(d["feat"]), "fragment": ctx.counter("reward_DEMOG_FRAGMENT_0"),
            "hasReward": bool(d["killed"]), "lastAttackDrawNum": 0,
            "pointValue": point_value(ctx, 1), "rank": 0, "rankGroupId": 0}


@route(26, 2)  # DEMOG_LIST
def demog_list(ctx: Context, req: dict):
    _expire(ctx)
    d = _demog_state(ctx)
    killed = [{"battleId": k["battle"], "id": long_id(int(k["id"])), "killFeat": int(k["feat"]),
               "lastAttackRewards": [], "level": int(k["level"]), "maxDamageRewards": [],
               "summonRewards": [], "summonerName": ctx.record.role_name} for k in d["killed"]]
    return {"demogList": [_vo(ctx, x) for x in d["list"]], "killedDemogList": killed}


@route(26, 14)  # REFRESH_DEMOG
def refresh_demog(ctx: Context, req: dict):
    _expire(ctx)
    d = _demog_state(ctx)
    demog = d["list"][0] if d["list"] else spawn(ctx)
    vo = _vo(ctx, demog)
    return {"activeId": _active(ctx), "battleId": demog["battle"], "currentHp": vo["currentHp"],
            "drawReward": list(d["drawn"]), "escapeTime": vo["escapeTime"], "feat": int(d["feat"]),
            "id": vo["id"], "lastAttackDrawNum": 0, "level": vo["level"],
            "pointValue": point_value(ctx, 1), "rank": 0, "summoner": vo["summoner"],
            "summonerName": vo["summonerName"], "totalHp": vo["totalHp"]}


@route(26, 3)  # ATTACK_DEMOG {allOut, demogId, embattle, summoner}
def attack(ctx: Context, req: dict):
    demog = _find(ctx, req.get("demogId"))
    if demog["hp"] <= 0 or demog["escape"] <= now_ms():
        raise GameError(-6, "demog gone")
    all_out = bool(req.get("allOut"))
    energy = int(ctx.config.value("DEMOG:ATTACK_ALL_OUT_ENERGY" if all_out else "DEMOG:ATTACK_NORMAL_ENERGY", 1))
    points = refresh_points(ctx)
    if int(points.get("1", 0)) < energy:
        raise GameError(ENERGY_NOT_ENOUGH, "energy")
    ledger = ctx.ledger()
    ledger.pay_action_point(energy, kind=1)
    from .battle import card_fighter
    from ..combat import MAJOR, MINOR
    reports, damage = [], 0
    boss = make_fighter(ctx.config, 6, demog["base"], demog["level"], BOSS)
    boss.hp, boss.max_hp = int(demog["hp"]), int(demog["total"])
    for grid in req.get("embattle") or []:
        team = []
        for r, row in enumerate(grid):
            for c, value in enumerate(row):
                card = ctx.card(as_id(value)) if as_id(value) else None
                if card:
                    team.append(card_fighter(ctx, r * 2 + c, card, MAJOR if not team else MINOR))
        if not team:
            continue
        if all_out:
            for unit in team:
                unit.attack = int(unit.attack * float(ctx.config.value("DEMOG:ALL_OUT_ATTACK_ADD", 2.5)))
        before = boss.hp
        _, report = fight(ctx.config, team, [boss])
        reports.append(report)
        damage += before - boss.hp
        if boss.hp <= 0:
            break
    if not reports:
        raise GameError(-1, "empty formation")
    d = _demog_state(ctx)
    demog["hp"] = max(0, boss.hp)
    demog["attacked"] = True
    demog["damages"][str(ctx.player_id)] = int(demog["damages"].get(str(ctx.player_id), 0)) + damage
    feat = max(1, damage // 100)  # 推测值
    d["feat"] = int(d["feat"]) + feat
    d["damage_max"] = max(int(d["damage_max"]), damage)
    killed = demog["hp"] <= 0
    if killed:
        d["list"].remove(demog)
        d["killed"].append({"id": demog["id"], "battle": demog["battle"], "level": demog["level"],
                            "feat": feat})
    ctx.save()
    return {"allOut": all_out, "costResult": ledger.costs, "damage": damage, "enemyNum": 1,
            "feat": feat, "groupNum": len(reports), "killed": killed, "luckHeros": [],
            "rankList": _damage_rank(ctx, demog), "reports": reports, "shared": False}


def _damage_rank(ctx: Context, demog: dict) -> list[dict]:
    rows = sorted(demog["damages"].items(), key=lambda kv: -int(kv[1]))
    return [{"damage": int(v), "id": long_id(int(k)), "name": ctx.record.role_name, "rank": i + 1}
            for i, (k, v) in enumerate(rows)]


@route(26, 4)  # TOTAL_DAMAGE_RANK {demogId, summoner}
def total_damage_rank(ctx: Context, req: dict):
    did = as_id(req.get("demogId"))
    demog = next((x for x in _demog_state(ctx)["list"] if int(x["id"]) == did), None)
    return _damage_rank(ctx, demog) if demog else []


@route(26, 13)  # DRAW_KILLED_DEMOG_REWARD {demogId}
def draw_killed(ctx: Context, req: dict):
    d = _demog_state(ctx)
    did = as_id(req.get("demogId"))
    kill = next((k for k in d["killed"] if int(k["id"]) == did), None)
    if kill is None:
        raise GameError(NOT_FOUND, "no reward")
    d["killed"].remove(kill)
    ledger = ctx.ledger()
    level = int(kill["level"])
    ledger.grant({"type": "DEMOG_FRAGMENT", "code": 0, "amount": 10 + level // 5})   # 推测值
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": 2000 + level * 200})      # 推测值
    ctx.save()
    return {"feat": int(kill["feat"]), "rank": 1, "rewardResults": ledger.rewards}


@route(26, 5)  # INVITE_FRIEND_ATTACK {demogId}: friends (bots) chip in
def invite_friends(ctx: Context, req: dict):
    demog = _find(ctx, req.get("demogId"))
    friends = ctx.state.get("social", {}).get("friends", [])
    helped = 0
    for fid in friends[:5]:
        hit = int(demog["total"] * random.uniform(0.01, 0.05))
        demog["hp"] = max(1, int(demog["hp"]) - hit)
        demog["damages"][str(fid)] = int(demog["damages"].get(str(fid), 0)) + hit
        helped += 1
    ctx.save()
    return helped


def _rank_rows(ctx: Context, my_value: int, label: str) -> list[dict]:
    rows = []
    for rank in range(1, int(ctx.config.value("DEMOG:RANK_LIST_SIZE", 5)) + 1):
        b = bot(ctx.config, BOT_BASE + 800 + rank, 70 - rank)
        rows.append({"artifactLevel": 0, "canPraise": True, "id": long_id(b.id),
                     "leaderBaseId": b.leader, "leaderCultivateVo": None, "leaderEquip": [],
                     "leaderLevel": b.level, "leaderTalisman": [], "level": b.level, "name": b.name,
                     "powerSkill": 0, "praiseNum": 0, "rank": rank,
                     "rankValue": (my_value + 1) * (6 - rank) * 10})
    return rows


@route(26, 6)  # MAX_DAMAGE_RANK
def max_damage_rank(ctx: Context, req: dict):
    return _rank_rows(ctx, int(_demog_state(ctx)["damage_max"]), "damage")


@route(26, 7)  # FEAT_RANK
def feat_rank(ctx: Context, req: dict):
    return _rank_rows(ctx, int(_demog_state(ctx)["feat"]), "feat")


@route(26, 15)  # ALL_RANK
def all_rank(ctx: Context, req: dict):
    d = _demog_state(ctx)
    return {"activeId": _active(ctx), "damageRank": 0,
            "damageRankList": _rank_rows(ctx, int(d["damage_max"]), "damage"),
            "featRank": 0, "featRankList": _rank_rows(ctx, int(d["feat"]), "feat")}


@route(26, 16)  # PRAISE_RANK {id}
def praise_rank(ctx: Context, req: dict):
    d = _demog_state(ctx)
    from .battle import _today
    if d.get("praise_day") == _today():
        raise GameError(-27, "praised today")
    d["praise_day"] = _today()
    ledger = ctx.ledger()
    ledger.grant({"type": "CURRENCY", "code": 0, "amount": 5000})  # 推测值
    ctx.save()
    return {"rankList": _rank_rows(ctx, int(d["feat"]), "feat"), "rewardResults": ledger.rewards}


@route(26, 8)  # BUY_ENERGY {type}: DEMOG:BUY_ENERGY_TYPE amounts
def buy_energy(ctx: Context, req: dict):
    amounts = ctx.config.value("DEMOG:BUY_ENERGY_TYPE", [1, 10, 20])
    index = int(req.get("type") or 0)
    if not 0 <= index < len(amounts):
        raise GameError(-1, "bad type")
    amount = int(amounts[index])
    price = int((ctx.config.value("POINT:DEMOG_BUY_COST", [20]) or [20])[0])
    ledger = ctx.ledger()
    ledger.pay_jade(price * amount, ctx.config.value("POINT:DEMOG_BUY_TYPE"))
    ledger.grant({"type": "ACTION_POINT", "code": 1, "amount": amount})
    return ledger.cost_and_reward()


@route(26, 10)  # DRAW_FEAT_REWARD {ids}
def draw_feat(ctx: Context, req: dict):
    d = _demog_state(ctx)
    table = ctx.config.index("FeatReward")
    ledger = ctx.ledger()
    for rid in req.get("ids") or []:
        row = table.get(int(rid))
        if row is None:
            raise GameError(-32, "no feat reward")
        if int(rid) in d["drawn"] or int(d["feat"]) < int(row["feat"]):
            raise GameError(-31, "cannot draw")
        ledger.grant_reward_id(row["rewardId"])
        d["drawn"].append(int(rid))
    ctx.save()
    return ledger.rewards


@route(26, 11)  # FRAGMENT_EXCHANGE {id}: 精元 -> hero (FragmentExchange)
def fragment_exchange(ctx: Context, req: dict):
    row = ctx.config.index("FragmentExchange").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(NOT_FOUND, "no exchange")
    d = _demog_state(ctx)
    used = int(d["exchange"].get(str(row["id"]), 0))
    if row.get("isLimit") == "true" and used >= int(row.get("limit") or 0):
        raise GameError(-28, "limit")
    if ctx.level < int(row.get("level") or 0):
        raise GameError(-30, "level")
    cost = int(row["fragment"])
    if ctx.counter("reward_DEMOG_FRAGMENT_0") < cost:
        raise GameError(-29, "fragments")
    ctx.add_counter("reward_DEMOG_FRAGMENT_0", -cost)
    ledger = ctx.ledger()
    ledger.pay_costs(parse_json(row.get("costItems"), []))
    ledger.grant({"type": "HERO", "code": int(row["heroId"]), "amount": 1})
    d["exchange"][str(row["id"])] = used + 1
    ctx.save()
    return {"configId": int(row["id"]), "costResults": ledger.costs, "exchangeNum": used + 1,
            "fragment": ctx.counter("reward_DEMOG_FRAGMENT_0"), "rewardResult": ledger.rewards}


@route(26, 17)  # RED_CARD_COMPOSE {id}: RedCardComposeConfig
def red_card_compose(ctx: Context, req: dict):
    row = ctx.config.index("RedCardComposeConfig").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(NOT_FOUND, "no config")
    if ctx.level < int(row.get("level") or 0):
        raise GameError(-34, "level")
    ledger = ctx.ledger()
    need = int(row.get("fragment") or 0)
    if ctx.counter("reward_DEMOG_FRAGMENT_0") < need:
        raise GameError(-29, "fragments")
    ctx.add_counter("reward_DEMOG_FRAGMENT_0", -need)
    for kind in parse_json(row.get("costType"), ["COPPER"]):
        ledger.pay_currency(kind, int(row.get("cost") or 0))
    ledger.grant_reward_id(row["rewardId"])
    return ledger.cost_and_reward()


@route(26, 9)  # RANK_GROUP_INFO {owner}
def rank_group_info(ctx: Context, req: dict):
    owner = as_id(req.get("owner"))
    b = bot(ctx.config, owner if owner >= BOT_BASE else BOT_BASE + owner)
    heroes = [[{"baseId": base, "level": level} for _, base, level in b.cards]]
    return {"curGroupId": 1, "groups": [{"artifactLevel": 0, "embattles": heroes, "groupId": 1,
                                         "leaderBaseId": b.leader, "userBuff": []}]}
