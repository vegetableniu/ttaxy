"""MsgTalisman (mod 49): 法宝 — pack, equip, upgrade, sell, 龙王寻宝.

TalismanSetting (id = TalismanVo.baseId) gives equip rules and max level;
TalismanLevelSetting "<id>_<level>" gives exp to next level ("exp"), the value
as upgrade material ("accumulateExp"), sell price and stat alters.
龙王寻宝: RankConfig ranks 0..4 (虾兵 … 东海龙王) with copper costs; each search
finds one talisman into a temporary pack and may advance the rank; RECEIVE
moves them to the pack.  Search odds/pools are 推测值.
"""

from __future__ import annotations

import random

from ..defaults import long_id
from ..game import Context, GameError, as_id, charge_times, parse_json, route

ARGUMENT_ILLEGAL = -1
NOT_FOUND = -2
PACK_FULL = -5
CANNOT_EQUIP = -10
MAX_LEVEL = -11
LEVEL_LIMIT = -12
ADVANCE_ODDS = [0.7, 0.55, 0.4, 0.25, 0.0]  # 推测值: chance to meet the next NPC


def _talismans(ctx: Context) -> list[dict]:
    return ctx.state.setdefault("talismans", [])


def _setting(ctx: Context, base: int) -> dict:
    return ctx.config.index("TalismanSetting").get(int(base), {})


def _level_row(ctx: Context, base: int, level: int) -> dict:
    return ctx.config.index("TalismanLevelSetting").get(f"{int(base)}_{int(level)}", {})


def talisman_vo(t: dict) -> dict:
    return {"baseId": int(t["base"]), "equipHero": long_id(int(t.get("hero", 0))),
            "exp": int(t.get("exp", 0)), "id": long_id(int(t["id"])), "level": int(t["level"])}


def capacity(ctx: Context) -> int:
    return int(ctx.config.value("TALISMAN:PACK_CAPACITY", 50)) + \
        int(ctx.state.get("talisman_extend", 0)) * int(ctx.config.value("TALISMAN:BUY_PACK_CAPACITY_VALUE", 5))


def grant_talisman(ctx: Context, ledger, base: int, level: int | None = None) -> dict:
    if len(_talismans(ctx)) >= capacity(ctx):
        raise GameError(PACK_FULL, "talisman pack full")
    setting = _setting(ctx, base)
    t = {"id": ctx.next_uid(), "base": int(base), "level": level or int(setting.get("initLevel") or 1),
         "exp": 0, "hero": 0}
    _talismans(ctx).append(t)
    ctx.save()
    ledger._result("TALISMAN", int(base), 1, [talisman_vo(t)])
    return t


def _find(ctx: Context, value) -> dict:
    tid = as_id(value)
    t = next((x for x in _talismans(ctx) if int(x["id"]) == tid), None)
    if t is None:
        raise GameError(NOT_FOUND, "talisman not found")
    return t


def card_alters(ctx: Context, card_id: int) -> dict:
    """Stat bonus of the talismans worn by a card (used by the battle simulator)."""
    total: dict = {}
    for t in _talismans(ctx):
        if int(t.get("hero", 0)) == card_id:
            for key, value in parse_json(_level_row(ctx, t["base"], t["level"]).get("alters"), {}).items():
                total[key] = total.get(key, 0) + float(value)
    return total


@route(49, 2)  # LOAD_ALL_TALISMAN
def load_all(ctx: Context, req: dict):
    return [talisman_vo(t) for t in _talismans(ctx)]


@route(49, 6)  # LOAD_TALISMAN {id}
def load_one(ctx: Context, req: dict):
    return talisman_vo(_find(ctx, req.get("id")))


@route(49, 1)  # LOAD_ALL_HERO_TALISMAN
def load_hero_talismans(ctx: Context, req: dict):
    worn: dict[int, list] = {}
    for t in _talismans(ctx):
        if int(t.get("hero", 0)):
            worn.setdefault(int(t["hero"]), []).append(talisman_vo(t))
    return [{"baseId": int(ctx.card(hid)["base_id"]) if ctx.card(hid) else 0,
             "id": long_id(hid), "talismanVos": vos} for hid, vos in worn.items()]


def _equip(ctx: Context, hero_id: int, ids: list[int], replace: bool) -> list:
    card = ctx.require_card(hero_id, NOT_FOUND)
    hero_type = ctx.config.heroes.get(int(card["base_id"]), {}).get("type")
    worn = [t for t in _talismans(ctx) if int(t.get("hero", 0)) == hero_id]
    if replace:
        for t in worn:
            t["hero"] = 0
        worn = []
    new = [_find(ctx, i) for i in ids]
    slots = int(ctx.config.value("TALISMAN:EQUIP_COUNT", 2))
    lock = ctx.config.index("Lock").get("TALISMAN_EQUIP_2_LOCK", {})
    if ctx.level < int(lock.get("level") or 0):
        slots = 1
    if len(worn) + len(new) > slots:
        raise GameError(CANNOT_EQUIP, "no free slot")
    races = [_setting(ctx, t["base"]).get("race") for t in worn]
    for t in new:
        setting = _setting(ctx, t["base"])
        if setting.get("canEquip") != "true" or hero_type not in parse_json(setting.get("equipTypes"), []):
            raise GameError(CANNOT_EQUIP, "cannot equip on this hero")
        if any(r in parse_json(setting.get("mutualRaces"), []) for r in races):
            raise GameError(CANNOT_EQUIP, "mutually exclusive talismans")
        races.append(setting.get("race"))
        t["hero"] = hero_id
    ctx.save()
    return [long_id(int(t["id"])) for t in _talismans(ctx) if int(t.get("hero", 0)) == hero_id]


@route(49, 3)  # EQUIP_TALISMAN {heroId, talismanIds}
def equip(ctx: Context, req: dict):
    return _equip(ctx, as_id(req.get("heroId")), [as_id(v) for v in req.get("talismanIds") or []], False)


@route(49, 18)  # REPLACE_HERO_TALISMANS
def replace(ctx: Context, req: dict):
    return _equip(ctx, as_id(req.get("heroId")), [as_id(v) for v in req.get("talismanIds") or []], True)


@route(49, 4)  # UNEQUIP_TALISMAN
def unequip(ctx: Context, req: dict):
    hero_id = as_id(req.get("heroId"))
    for value in req.get("talismanIds") or []:
        t = _find(ctx, value)
        if int(t.get("hero", 0)) == hero_id:
            t["hero"] = 0
    ctx.save()
    return [long_id(int(t["id"])) for t in _talismans(ctx) if int(t.get("hero", 0)) == hero_id]


def _feed(ctx: Context, target: dict, values) -> int:
    ids = [as_id(v) for v in values or []]
    if not ids or len(ids) > int(ctx.config.value("TALISMAN:MAX_UPGRADE_MATERIAL_COUNT", 6)):
        raise GameError(ARGUMENT_ILLEGAL, "material count")
    gained = 0
    for tid in ids:
        mat = _find(ctx, tid)
        if mat is target or int(mat.get("hero", 0)):
            raise GameError(ARGUMENT_ILLEGAL, "invalid material")
        if _setting(ctx, mat["base"]).get("canSwallow") == "false" and \
                _setting(ctx, mat["base"]).get("race") != "EXP_1":
            raise GameError(ARGUMENT_ILLEGAL, "cannot be consumed")
        gained += int(_level_row(ctx, mat["base"], mat["level"]).get("accumulateExp") or 0) + int(mat.get("exp", 0))
        _talismans(ctx).remove(mat)
    return gained


def _level_up(ctx: Context, t: dict, gained: int) -> None:
    max_level = int(_setting(ctx, t["base"]).get("maxLevel") or 1)
    exp = int(t.get("exp", 0)) + gained
    while int(t["level"]) < max_level:
        need = int(_level_row(ctx, t["base"], t["level"]).get("exp") or 0)
        if need <= 0 or exp < need:
            break
        exp -= need
        t["level"] = int(t["level"]) + 1
    t["exp"] = 0 if int(t["level"]) >= max_level else exp
    ctx.save()


@route(49, 7)  # UPGRADE_TALISMAN {talismanId, talismanIds}
def upgrade(ctx: Context, req: dict):
    t = _find(ctx, req.get("talismanId"))
    if int(t["level"]) >= int(_setting(ctx, t["base"]).get("maxLevel") or 1):
        raise GameError(MAX_LEVEL, "max level")
    _level_up(ctx, t, _feed(ctx, t, req.get("talismanIds")))
    return talisman_vo(t)


@route(49, 21)  # ADVANCE_TALISMAN (推测: same exp rules as upgrade)
def advance(ctx: Context, req: dict):
    return upgrade(ctx, req)


@route(49, 22)  # ADVANCE_SWALLOW_TALISMAN
def advance_swallow(ctx: Context, req: dict):
    t = _find(ctx, req.get("talismanId"))
    _level_up(ctx, t, _feed(ctx, t, req.get("talismanIds")))
    return talisman_vo(t)


@route(49, 20)  # CONVERT_TALISMAN: take a same-position talisman's form (推测值)
def convert(ctx: Context, req: dict):
    t = _find(ctx, req.get("talismanId"))
    ids = [as_id(v) for v in req.get("talismanIds") or []]
    if len(ids) != 1:
        raise GameError(ARGUMENT_ILLEGAL, "one template talisman")
    other = _find(ctx, ids[0])
    if _setting(ctx, other["base"]).get("position") != _setting(ctx, t["base"]).get("position"):
        raise GameError(ARGUMENT_ILLEGAL, "position differs")
    _talismans(ctx).remove(other)
    t["base"] = int(other["base"])
    t["level"] = min(int(t["level"]), int(_setting(ctx, t["base"]).get("maxLevel") or 1))
    ctx.save()
    return talisman_vo(t)


@route(49, 9)  # CELL_TALISMAN (sell)
def sell(ctx: Context, req: dict):
    ledger = ctx.ledger()
    copper = 0
    for value in req.get("talismanIds") or []:
        t = _find(ctx, value)
        if int(t.get("hero", 0)):
            raise GameError(ARGUMENT_ILLEGAL, "worn")
        copper += int(_level_row(ctx, t["base"], t["level"]).get("price") or _setting(ctx, t["base"]).get("price") or 0)
        _talismans(ctx).remove(t)
    if copper:
        ledger.grant({"type": "CURRENCY", "code": 0, "amount": copper})
    ctx.save()
    return ledger.rewards


@route(49, 8)  # GET_FRAGMENT
def get_fragment(ctx: Context, req: dict):
    return {"extendLimit": capacity(ctx), "fragment": ctx.counter("reward_TALISMAN_FRAGMENT_0"),
            "id": long_id(ctx.player_id), "liebi": ctx.counter("reward_TALISMAN_LIEBI_0"),
            "used": len(_talismans(ctx))}


@route(49, 5)  # EXCHANGE_TALISMAN {id}: FragmentExSetting
def exchange(ctx: Context, req: dict):
    row = ctx.config.index("FragmentExSetting").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(NOT_FOUND, "no such exchange")
    if not int(row["minLevel"]) <= ctx.level <= int(row["maxLevel"]):
        raise GameError(LEVEL_LIMIT, "level")
    key = "reward_TALISMAN_LIEBI_0" if row.get("costType") == "LIEBI" else "reward_TALISMAN_FRAGMENT_0"
    if ctx.counter(key) < int(row["fragment"]):
        raise GameError(-13, "fragments")
    ctx.add_counter(key, -int(row["fragment"]))
    ledger = ctx.ledger()
    ledger.grant_reward_id(row["rewardId"])
    return {"fragment": ctx.counter("reward_TALISMAN_FRAGMENT_0"),
            "liebi": ctx.counter("reward_TALISMAN_LIEBI_0"), "rewardResult": ledger.rewards}


def _buy_space(ctx: Context, jade: bool):
    if int(ctx.state.get("talisman_extend", 0)) >= int(ctx.config.value("TALISMAN:MAX_BUY_PACK_CAPACITY_TIMES", 50)):
        raise GameError(PACK_FULL, "limit")
    ledger = ctx.ledger()
    if jade:
        ledger.pay_jade(int(ctx.config.value("TALISMAN:DEFAULT_BUY_PACK_CAPACITY_COST", 400)),
                        ctx.config.value("TALISMAN:BUY_PACK_CAPACITY_COST_TYPE"))
    else:
        ledger.pay_currency("COUPON", int(ctx.config.value("TALISMAN:BUY_PACK_CAPACITY_BY_COUPON_COST", 2)))
    ctx.state["talisman_extend"] = int(ctx.state.get("talisman_extend", 0)) + 1
    ctx.save()
    return {"extendLimit": capacity(ctx), "vcoinCost": ledger.costs}


@route(49, 15)  # BUY_TALISMAN_PACK_SPACE
def buy_space(ctx: Context, req: dict):
    return _buy_space(ctx, True)


@route(49, 19)  # BUY_TALISMAN_PACK_SPACE_BY_COUPON
def buy_space_coupon(ctx: Context, req: dict):
    return _buy_space(ctx, False)


# ------------------------------------------------------------ 龙王寻宝
def _hunt(ctx: Context) -> dict:
    return ctx.state.setdefault("talisman_hunt", {"rank": 0, "treasures": [], "dragon": 0})


def _treasure_pool(ctx: Context, rank: int) -> list[int]:
    tiers = {0: (1000, 2000), 1: (2000, 4000), 2: (4000, 8000), 3: (8000, 16000), 4: (16000, 99999)}
    low, high = tiers.get(rank, (1000, 2000))
    pool = [int(t["id"]) for t in ctx.config.rows("TalismanSetting")
            if t["type"] == "NORMAL" and low <= int(t["price"]) <= high
            and int(t["minPlayerLevel"]) <= max(ctx.level, 58) and not t.get("activityType")]
    return pool or [102]


def _look(ctx: Context) -> dict:
    hunt = _hunt(ctx)
    rank = int(hunt["rank"])
    row = ctx.config.index("RankConfig").get(rank, {})
    ledger = ctx.ledger()
    ledger.pay_currency("COPPER", int(row.get("costs") or 0))
    size = int(ctx.config.value("TALISMAN:TMP_PACK_SIZE", 12))
    if len(hunt["treasures"]) >= size:
        raise GameError(PACK_FULL, "temporary pack full")
    found = random.choice(_treasure_pool(ctx, rank))
    hunt["treasures"].append(found)
    if random.random() < ADVANCE_ODDS[min(rank, len(ADVANCE_ODDS) - 1)]:
        hunt["rank"] = min(rank + 1, 4)
    else:
        hunt["rank"] = 0
    ctx.save()
    return {"costs": list(ledger.costs), "rank": int(hunt["rank"]), "treasures": [found]}


@route(49, 10)  # GET_TALISMAN_TMP_PACK_INFO
def tmp_pack(ctx: Context, req: dict):
    hunt = _hunt(ctx)
    return {"openDragonCount": int(hunt["dragon"]), "rank": int(hunt["rank"]),
            "treasures": list(hunt["treasures"])}


@route(49, 11)  # LOOKFOR
def lookfor(ctx: Context, req: dict):
    if ctx.level < int(ctx.config.index("Lock").get("TALISMAN", {}).get("level") or 0):
        raise GameError(LEVEL_LIMIT, "level")
    return _look(ctx)


@route(49, 12)  # AUTO_LOOKFOR: search until the temporary pack is full
def auto_lookfor(ctx: Context, req: dict):
    if charge_times(ctx, "AUTO_GET_TALISMAN", 0) <= 0 and \
            int(ctx.wallet.get("totalCharge", 0)) <= 0:
        raise GameError(-27, "recharge perk")
    results = []
    size = int(ctx.config.value("TALISMAN:TMP_PACK_SIZE", 12))
    while len(_hunt(ctx)["treasures"]) < size:
        try:
            results.append(_look(ctx))
        except GameError:
            break
    return results


@route(49, 13)  # RECEIVE: move the temporary pack into the talisman pack
def receive(ctx: Context, req: dict):
    hunt = _hunt(ctx)
    ledger = ctx.ledger()
    sold = 0
    for base in list(hunt["treasures"]):
        if len(_talismans(ctx)) >= capacity(ctx):
            price = int(_setting(ctx, base).get("price") or 0)
            ledger.grant({"type": "CURRENCY", "code": 0, "amount": price})
            sold += 1
        else:
            grant_talisman(ctx, ledger, base)
    hunt["treasures"] = []
    ctx.save()
    return {"rewards": ledger.rewards, "solds": sold}


@route(49, 14)  # OPEN_DRAGON_KING: jump straight to 东海龙王
def open_dragon_king(ctx: Context, req: dict):
    ledger = ctx.ledger()
    ledger.pay_jade(int(ctx.config.value("TALISMAN:ACCESS_DRAGON_KING_COST", 500)),
                    ctx.config.value("TALISMAN:ACCESS_DRAGON_KING_COST_TYPE"))
    hunt = _hunt(ctx)
    hunt["rank"] = int(ctx.config.value("TALISMAN:DRAGON_KING_ID", 5)) - 1
    hunt["dragon"] = int(hunt["dragon"]) + 1
    ctx.save()
    return {"rank": int(hunt["rank"]), "vcoinCost": ledger.costs}


@route(49, 16)  # GET_GAINED_REWARDS (talisman activity goals)
def gained_rewards(ctx: Context, req: dict):
    return {k: list(v) for k, v in ctx.state.get("talisman_goals", {}).items()}


@route(49, 17)  # GAIN_REWARD {activityType, goalRewardId}: ArtifactUpgradeActivity goals
def gain_reward(ctx: Context, req: dict):
    goal = str(req.get("goalRewardId") or "")
    row = ctx.config.index("ArtifactUpgradeActivity").get(goal)
    if row is None:
        raise GameError(-31, "goal not found")
    done = ctx.state.setdefault("talisman_goals", {}).setdefault(str(req.get("activityType") or ""), [])
    if goal in done:
        raise GameError(-33, "already gained")
    level = int(str(row["targetLevel"]).rstrip("阶") or 0)
    if int(ctx.state.get("artifact", {}).get("level", 0)) < level:
        raise GameError(-32, "condition not reached")
    ledger = ctx.ledger()
    amount = int("".join(ch for ch in row["content"].split("*")[-1] if ch.isdigit()) or 1)
    ledger.grant({"type": "SOUL_STONE", "code": int(row["showid"]), "amount": amount})
    done.append(goal)
    ctx.save()
    return ledger.rewards
