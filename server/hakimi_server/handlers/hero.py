"""MsgHero (mod 13): cards, growth, formations and teams.

Formulas are taken from the stock client (Logic/Hero, UI/HeroUpgrade,
UI/HeroEvolution bytecode) so server results match the client's previews:
  feed exp      = floor(baseExp + level * growExp)          (GetHeroSwallowExp)
  swallow cost  = floor(total feed exp * main.coinRate) copper (HeroUpgradeCostView)
  level-up need = floor(HeroLevelConfig[level].exp * expRate) (GetHeroNextExp)
  max level     = BaseHero.level
  sell price    = floor(baseCoins + level * growCoins) copper (GetHeroPrice)
  rank up       = at max level, costHeros {baseId: n} + costCoins copper;
                  keeps level/exp, baseId -> nextId (evolution preview)
  skill up      = skill cards add BaseHero.baseExp skill exp; SkillConfig.exps
                  per level, allowed cards in SkillConfig.costItems
"""

from __future__ import annotations

import random

from ..defaults import long_id
from ..game import (
    Context, GameError, as_id, embattle_ids, floor, group_vo, parse_json, route,
)

HERO_NOT_FOUND = -2
NOT_ENOUGHT_LEADERSHIP = -3
INVALID_OPERATE = -5
BLOCK_BY_LEVEL = -6
CANT_RANK_UP = -7
SKILL_NOT_FOUND = -11
HERO_IN_CURRENT = -13
BUY_LIMIT = -14
HERO_LOCKED = -15
SKILL_MAX_LEVEL = -16
HERO_NOT_ENOUGH = -17
HERO_GROUP_NOT_FOUND = -18
MUST_SET_LEADER = -20
SPLIT_HERO_CONFIG_ERROR = -25
RED_CARD_MAX_EXCHANGE_LIMIT = -30
RED_CARD_NOT_MATCH = -28
EMPTY_NAME = -41
TEAM_NOT_EXIST = -51
ONLY_HERO_CARD = -50
ARGUMENT_ILLEGAL = -1
NO_HERO_COST_RANK_UP_CONFIG = -68
ERROR_MATERIALS = -70

# 推测值: pack extension price/size are not in any client table.
PACK_EXTEND_SLOTS = 5
PACK_EXTEND_GOLD = 50


def _base(ctx: Context, card: dict) -> dict:
    return ctx.config.heroes.get(int(card["base_id"]), {})


def _card(ctx: Context, value) -> dict:
    return ctx.require_card(as_id(value), HERO_NOT_FOUND)


def _consume(ctx: Context, card: dict) -> None:
    """Remove a material card; locked or fielded cards cannot be consumed."""
    if card.get("locked"):
        raise GameError(HERO_LOCKED, "card locked")
    if int(card["id"]) in ctx.cards_in_use():
        raise GameError(HERO_IN_CURRENT, "card in formation")
    ctx.ledger().pay_card(card)


def _materials(ctx: Context, src: dict, values) -> list[dict]:
    cards, seen = [], set()
    for value in values or []:
        card = _card(ctx, value)
        if card is src or int(card["id"]) in seen:
            raise GameError(ARGUMENT_ILLEGAL, "invalid material")
        seen.add(int(card["id"]))
        cards.append(card)
    return cards


def feed_exp(ctx: Context, card: dict) -> int:
    info = _base(ctx, card)
    return floor(float(info.get("baseExp") or 0)
                 + int(card.get("level", 1)) * float(info.get("growExp") or 0))


def next_exp(ctx: Context, card: dict, level: int) -> int:
    row = ctx.config.index("HeroLevelConfig").get(level)
    if not row:
        return 0
    return floor(float(row.get("exp") or 0) * float(_base(ctx, card).get("expRate") or 0))


def gain_exp(ctx: Context, card: dict, amount: int) -> None:
    max_level = int(_base(ctx, card).get("level") or 1)
    level, exp = int(card.get("level", 1)), int(card.get("exp", 0)) + amount
    while level < max_level:
        need = next_exp(ctx, card, level)
        if need <= 0 or exp < need:
            break
        exp -= need
        level += 1
    if level >= max_level:
        exp = 0
    card["level"], card["exp"] = level, exp
    ctx.save()


def pack_limit(ctx: Context) -> int:
    row = ctx.config.levels.get(ctx.level, {})
    return int(row.get("packSize") or 20) + int(ctx.state.get("pack_extend", 0))


def leadership_limit(ctx: Context) -> int:
    row = ctx.config.levels.get(ctx.level, {})
    return int(row.get("leadership") or 15) + ctx.counter("leadership_bonus") \
        + ctx.counter("reward_LEADERSHIP_0")


def _group(ctx: Context, group_id: int) -> dict:
    for group in ctx.groups["groups"]:
        if int(group["groupId"]) == int(group_id):
            return group
    raise GameError(HERO_GROUP_NOT_FOUND, f"group {group_id}")


def _validate_formation(ctx: Context, leader: int, embattles: list[list[int]]) -> None:
    ids = [v for row in embattles for v in row if v]
    if len(ids) != len(set(ids)):
        raise GameError(-47, "repeat hero")
    if leader and leader not in ids:
        raise GameError(MUST_SET_LEADER, "leader not fielded")
    total = 0
    for card_id in ids:
        card = ctx.require_card(card_id, HERO_NOT_FOUND)
        info = _base(ctx, card)
        if info.get("card") != "HERO":
            raise GameError(ONLY_HERO_CARD, "only hero cards can be fielded")
        total += int(info.get("leadership") or 0)
    if total > leadership_limit(ctx):
        raise GameError(NOT_ENOUGHT_LEADERSHIP, "leadership exceeded")


def _set_formation(ctx: Context, group: dict, leader: int, embattles: list[list[int]]) -> None:
    _validate_formation(ctx, leader, embattles)
    group["leaderId"], group["embattles"] = leader, embattles
    ctx.save()


def _embattles_vo(group: dict) -> list:
    return group_vo(group)["embattles"]


def hero_pack(ctx: Context) -> dict:
    groups = ctx.groups
    current = _group(ctx, groups["curGroupId"])
    return {
        "extendCount": int(ctx.state.get("pack_extend", 0)) // PACK_EXTEND_SLOTS,
        "extendLimit": int(ctx.state.get("pack_extend", 0)),
        "heros": [ctx.hero_vo(c) for c in ctx.cards],
        "leader": long_id(int(current["leaderId"])),
        "score": [],
    }


@route(13, 1)  # ALL_HEROS
def all_heros(ctx: Context, req: dict):
    return hero_pack(ctx)


@route(13, 2)  # HERO_CURRENT: choose which cards are fielded in a group
def hero_current(ctx: Context, req: dict):
    group = _group(ctx, int(req.get("groupId") or 1))
    chosen = [as_id(v) for v in req.get("heros") or [] if as_id(v)]
    leader = int(group["leaderId"])
    if leader and leader not in chosen:
        chosen.insert(0, leader)
    if not leader and chosen:
        leader = chosen[0]
    # keep cards that stay in their slot, fill the free slots in order
    grid = [[v if v in chosen else 0 for v in row] for row in group["embattles"]]
    placed = {v for row in grid for v in row if v}
    pending = [v for v in chosen if v not in placed]
    for row in grid:
        for index, value in enumerate(row):
            if not value and pending:
                row[index] = pending.pop(0)
    if pending:
        raise GameError(ARGUMENT_ILLEGAL, "too many cards")
    _set_formation(ctx, group, leader, grid)
    return _embattles_vo(group)


@route(13, 3)  # EMBATTLE: swap two slots of the current group (0-based row/col)
def embattle(ctx: Context, req: dict):
    src, tar = list(req.get("src") or []), list(req.get("tar") or [])
    group = _group(ctx, ctx.groups["curGroupId"])
    grid = [list(row) for row in group["embattles"]]
    try:
        grid[src[0]][src[1]], grid[tar[0]][tar[1]] = grid[tar[0]][tar[1]], grid[src[0]][src[1]]
    except (IndexError, TypeError) as error:
        raise GameError(ARGUMENT_ILLEGAL, "bad slot") from error
    _set_formation(ctx, group, int(group["leaderId"]), grid)
    return 0


@route(13, 8)  # CHANGE_LEADER
def change_leader(ctx: Context, req: dict):
    group = _group(ctx, int(req.get("groupId") or ctx.groups["curGroupId"]))
    new, old = as_id(req.get("src")), int(group["leaderId"])
    ctx.require_card(new, HERO_NOT_FOUND)
    grid = [list(row) for row in group["embattles"]]
    ids = [v for row in grid for v in row]
    if new not in ids:
        grid = [[new if v == old else v for v in row] for row in grid]
    _set_formation(ctx, group, new, grid)
    return _embattles_vo(group)


@route(13, 13)  # HERO_GROUPS
def hero_groups(ctx: Context, req: dict):
    groups = ctx.groups
    return {"curGroupId": int(groups["curGroupId"]),
            "groups": [group_vo(g) for g in groups["groups"]]}


@route(13, 14)  # SWITCH_HERO_GROUP: selected group becomes group 1
def switch_hero_group(ctx: Context, req: dict):
    target = int(req.get("groupId") or 1)
    groups = ctx.groups["groups"]
    first, chosen = _group(ctx, 1), _group(ctx, target)
    first["groupId"], chosen["groupId"] = target, 1
    groups.sort(key=lambda g: int(g["groupId"]))
    ctx.groups["curGroupId"] = 1
    ctx.save()
    return target


@route(13, 21)  # SWITCH_GROUP: exchange groups 2 and 3
def switch_group(ctx: Context, req: dict):
    second, third = _group(ctx, 2), _group(ctx, 3)
    second["groupId"], third["groupId"] = 3, 2
    ctx.groups["groups"].sort(key=lambda g: int(g["groupId"]))
    ctx.save()
    return True


@route(13, 15)  # EMBATTLE_GROUP: replace a whole group's grid
def embattle_group(ctx: Context, req: dict):
    group = _group(ctx, int(req.get("groupId") or 1))
    grid = embattle_ids(req.get("embattle"))
    ids = [v for row in grid for v in row if v]
    leader = int(group["leaderId"])
    if leader not in ids:
        leader = ids[0] if ids else 0
    _set_formation(ctx, group, leader, grid)
    return 0


@route(13, 12)  # CURRENT_SCORE: [formation index, power]
def current_score(ctx: Context, req: dict):
    return [0, formation_power(ctx)]


def formation_power(ctx: Context) -> int:
    """Sum of fielded cards' ATTACK+LIFE/10 (same stats the client shows)."""
    import json as _json
    group = _group(ctx, ctx.groups["curGroupId"])
    total = 0
    for card_id in {v for row in group["embattles"] for v in row if v}:
        card = ctx.card(card_id)
        if not card:
            continue
        info = _base(ctx, card)
        init = parse_json(info.get("initValues"), {})
        grow = parse_json(info.get("initGrows"), {})
        level = int(card.get("level", 1))
        attack = init.get("ATTACK", 0) + level * grow.get("ATTACK", 0)
        life = init.get("LIFE", 0) + level * grow.get("LIFE", 0)
        total += int(attack + life / 10)
    return total


@route(13, 4)  # SWALLOW: feed cards into src
def swallow(ctx: Context, req: dict):
    src = _card(ctx, req.get("src"))
    info = _base(ctx, src)
    if int(src.get("level", 1)) >= int(info.get("level") or 1):
        raise GameError(BLOCK_BY_LEVEL, "already max level")
    materials = _materials(ctx, src, req.get("tar"))
    if not materials:
        raise GameError(ARGUMENT_ILLEGAL, "no material")
    total = sum(feed_exp(ctx, card) for card in materials)
    ledger = ctx.ledger()
    ledger.pay_currency("COPPER", floor(total * float(info.get("coinRate") or 0)))
    for card in materials:
        _consume(ctx, card)
    gain_exp(ctx, src, total)
    return {"costs": ledger.costs, "hero": ctx.hero_vo(src)}


def _skill_after_rank(ctx: Context, card: dict, next_info: dict) -> int:
    """Keep the skill level when the evolved card has a different skill."""
    skills = ctx.config.index("SkillConfig")
    current = skills.get(int(card.get("power_skill") or 0))
    target = int(parse_json(next_info.get("powerSkill"), 0) or 0)
    if not current or not target or not skills.get(target):
        return target or int(card.get("power_skill") or 0)
    if skills[target].get("skillname") == current.get("skillname"):
        return int(card["power_skill"])
    for _ in range(int(current.get("level") or 1) - 1):
        nxt = int(skills.get(target, {}).get("next") or -1)
        if nxt <= 0 or nxt not in skills:
            break
        target = nxt
    return target


def _rank_up(ctx: Context, src: dict) -> dict:
    info = _base(ctx, src)
    next_id = int(info.get("nextId") or -1)
    if next_id <= 0 or next_id not in ctx.config.heroes:
        raise GameError(CANT_RANK_UP, "cannot rank up")
    if int(src.get("level", 1)) < int(info.get("level") or 1):
        raise GameError(BLOCK_BY_LEVEL, "not max level")
    src["power_skill"] = _skill_after_rank(ctx, src, ctx.config.heroes[next_id])
    src["base_id"] = next_id
    ctx.save()
    return src


@route(13, 5)  # RANK_UP (evolution with material cards)
def rank_up(ctx: Context, req: dict):
    src = _card(ctx, req.get("src"))
    info = _base(ctx, src)
    need = {int(k): int(v) for k, v in parse_json(info.get("costHeros"), {}).items()}
    materials = _materials(ctx, src, req.get("tar"))
    have: dict[int, list[dict]] = {}
    for card in materials:
        have.setdefault(int(card["base_id"]), []).append(card)
    if any(len(have.get(base, [])) < count for base, count in need.items()):
        raise GameError(HERO_NOT_ENOUGH, "materials missing")
    ledger = ctx.ledger()
    _rank_up(ctx, src)  # validates level / nextId before paying
    ledger.pay_currency("COPPER", int(info.get("costCoins") or 0))
    for base, count in need.items():
        for card in have[base][:count]:
            _consume(ctx, card)
    return {"costs": ledger.costs, "hero": ctx.hero_vo(src)}


@route(13, 16)  # RANK_UP_BY_GOLD
def rank_up_by_gold(ctx: Context, req: dict):
    src = _card(ctx, req.get("src"))
    info = _base(ctx, src)
    gold = int(info.get("costGold") or 0)
    if gold <= 0:
        raise GameError(-23, "gold rank up not open")
    ledger = ctx.ledger()
    _rank_up(ctx, src)
    ledger.pay_currency("GOLD", gold)
    return {"costs": ledger.costs, "hero": ctx.hero_vo(src)}


@route(13, 11)  # SKILL_UP
def skill_up(ctx: Context, req: dict):
    src = _card(ctx, req.get("src"))
    skills = ctx.config.index("SkillConfig")
    skill = skills.get(int(src.get("power_skill") or 0))
    if not skill:
        raise GameError(SKILL_NOT_FOUND, "no skill")
    if int(skill.get("next") or -1) <= 0:
        raise GameError(SKILL_MAX_LEVEL, "max skill")
    allowed = set(parse_json(skill.get("costItems"), []))
    materials = _materials(ctx, src, req.get("tar"))
    if not materials:
        raise GameError(ARGUMENT_ILLEGAL, "no material")
    gained = 0
    for card in materials:
        if allowed and int(card["base_id"]) not in allowed:
            raise GameError(ERROR_MATERIALS, "card cannot train this skill")
        gained += int(_base(ctx, card).get("baseExp") or 0)
    ledger = ctx.ledger()
    ledger.pay_currency("COPPER", int(skill.get("costCoins") or 0))
    for card in materials:
        _consume(ctx, card)
    exp = int(src.get("skill_exp", 0)) + gained
    while skill and int(skill.get("next") or -1) > 0 and exp >= int(skill.get("exps") or 0):
        exp -= int(skill.get("exps") or 0)
        src["power_skill"] = int(skill["next"])
        skill = skills.get(int(skill["next"]))
    if skill and int(skill.get("next") or -1) <= 0:
        exp = 0
    src["skill_exp"] = exp
    ctx.save()
    return {"costs": ledger.costs, "hero": ctx.hero_vo(src)}


@route(13, 7)  # SELL_HERO
def sell_hero(ctx: Context, req: dict):
    ledger = ctx.ledger()
    total = 0
    for value in req.get("tar") or []:
        card = _card(ctx, value)
        info = _base(ctx, card)
        total += floor(float(info.get("baseCoins") or 0)
                       + int(card.get("level", 1)) * float(info.get("growCoins") or 0))
        _consume(ctx, card)
    if total:
        ledger.grant({"type": "CURRENCY", "code": 0, "amount": total})
    return ledger.cost_and_reward()


@route(13, 9)  # CRUSH_HERO: recycle into purple/orange soul currency
def crush_hero(ctx: Context, req: dict):
    ledger = ctx.ledger()
    table = ctx.config.index("RecycleSetting")
    for value in req.get("tar") or []:
        card = _card(ctx, value)
        info = _base(ctx, card)
        row = table.get(f"CARD_TYPE:{info.get('card')}:{info.get('rank')}:{info.get('star')}")
        if row is None:
            raise GameError(INVALID_OPERATE, "card cannot be recycled")
        _consume(ctx, card)
        ledger.grant_all(parse_json(row.get("fixCounts"), []))
        rate = (parse_json(row.get("rates"), [0]) or [0])[0]
        if random.random() < float(rate):
            ledger.grant_all(parse_json(row.get("randomCounts"), []))
    return ledger.cost_and_reward()


@route(13, 17)  # SPLIT_HERO: split an evolved card back into base cards
def split_hero(ctx: Context, req: dict):
    card = _card(ctx, req.get("tar"))
    info = _base(ctx, card)
    parts = parse_json(info.get("splitId"), {})
    if not isinstance(parts, dict) or not parts:
        raise GameError(SPLIT_HERO_CONFIG_ERROR, "card cannot be split")
    if len(ctx.cards) - 1 + sum(int(v) for v in parts.values()) > pack_limit(ctx):
        raise GameError(-26, "pack full")
    ledger = ctx.ledger()
    # 推测值: split fee currency is not named in the client; GOLD (仙玉) is used.
    ledger.pay_currency("GOLD", int(info.get("splitCostAmount") or 0))
    _consume(ctx, card)
    for base, count in parts.items():
        ledger.grant({"type": "HERO", "code": int(base), "amount": int(count)})
    return ledger.cost_and_reward()


@route(13, 10)  # LOCK
def lock(ctx: Context, req: dict):
    card = _card(ctx, req.get("src"))
    card["locked"] = bool(req.get("lock"))
    ctx.save()
    return 0


def _buy_pack(ctx: Context, currency: str) -> dict:
    ledger = ctx.ledger()
    ledger.pay_currency(currency, PACK_EXTEND_GOLD)
    ctx.state["pack_extend"] = int(ctx.state.get("pack_extend", 0)) + PACK_EXTEND_SLOTS
    ctx.save()
    extend = int(ctx.state["pack_extend"])
    return {"costs": ledger.costs, "extendCount": extend // PACK_EXTEND_SLOTS,
            "extendLimit": extend}


@route(13, 6)  # BUY_PACK
def buy_pack(ctx: Context, req: dict):
    return _buy_pack(ctx, "GOLD")


@route(13, 18)  # BUY_PACK_BY_COUPON
def buy_pack_by_coupon(ctx: Context, req: dict):
    return _buy_pack(ctx, "COUPON")


@route(13, 26)  # COST_RANK_UP (飞升: HeroCostRankUp)
def cost_rank_up(ctx: Context, req: dict):
    row = ctx.config.index("HeroCostRankUp").get(int(req.get("configId") or 0))
    if row is None:
        raise GameError(NO_HERO_COST_RANK_UP_CONFIG, "no config")
    same = parse_json(row.get("costSameNameId"), [])
    stars = parse_json(row.get("costMinStar"), [])
    levels = parse_json(row.get("costMinLevel"), [])
    ids = [as_id(v) for v in req.get("heroIds") or []]
    if len(ids) != len(same):
        raise GameError(ERROR_MATERIALS, "material count")
    cards = [ctx.require_card(i, HERO_NOT_FOUND) for i in ids]
    for index, card in enumerate(cards):
        info = _base(ctx, card)
        if (int(info.get("sameNameId") or 0) != int(same[index])
                or int(info.get("star") or 0) < int(stars[index])
                or int(card.get("level", 1)) < int(levels[index])):
            raise GameError(ERROR_MATERIALS, "material mismatch")
    ledger = ctx.ledger()
    ledger.pay_costs(parse_json(row.get("costItems"), []))
    for card in cards:
        _consume(ctx, card)
    ledger.grant_reward_id(row.get("rewardId"))
    return ledger.cost_and_reward()


@route(13, 19)  # GET_RED_CARD_EXCHANGE_INFO
def red_card_info(ctx: Context, req: dict):
    return {int(k): int(v) for k, v in ctx.state.get("red_card_exchange", {}).items()}


@route(13, 20)  # RED_CARD_EXCHANGE
def red_card_exchange(ctx: Context, req: dict):
    config_id = int(req.get("configId") or 0)
    row = ctx.config.index("RedCardExchange").get(config_id)
    if row is None:
        raise GameError(-27, "exchange not open")
    record = ctx.state.setdefault("red_card_exchange", {})
    if int(record.get(str(config_id), 0)) >= int(row.get("maxExchangeNum") or 1):
        raise GameError(RED_CARD_MAX_EXCHANGE_LIMIT, "limit")
    if ctx.level < int(row.get("playerLevel") or 0):
        raise GameError(BLOCK_BY_LEVEL, "level")
    same = parse_json(row.get("costSameNameId"), [])
    stars = parse_json(row.get("costMinStar"), [])
    cards = [_card(ctx, v) for v in req.get("costHeroIds") or []]
    if len(cards) != len(same):
        raise GameError(RED_CARD_NOT_MATCH, "count")
    for index, card in enumerate(cards):
        info = _base(ctx, card)
        if int(info.get("sameNameId") or 0) != int(same[index]) \
                or int(info.get("star") or 0) < int(stars[index]):
            raise GameError(RED_CARD_NOT_MATCH, "mismatch")
    ledger = ctx.ledger()
    for card in cards:
        _consume(ctx, card)
    ledger.grant({"type": "HERO", "code": int(row["heroId"]), "amount": 1})
    record[str(config_id)] = int(record.get(str(config_id), 0)) + 1
    ctx.save()
    return {"costAndReward": ledger.cost_and_reward(),
            "exchangeRecord": {int(k): int(v) for k, v in record.items()}}


# ---- saved teams (阵容保存) ------------------------------------------------
def _teams(ctx: Context) -> dict:
    return ctx.state.setdefault("teams", {})


@route(13, 22)  # UPDATE_TEAM
def update_team(ctx: Context, req: dict):
    name = str(req.get("name") or "").strip()
    if not name:
        raise GameError(EMPTY_NAME, "empty name")
    if len(name) > 12:
        raise GameError(-67, "name too long")
    teams = [[[as_id(v) for v in row] for row in grid] for grid in req.get("teams") or []]
    leaders = [as_id(v) for v in req.get("leaders") or []]
    if len(teams) != len(leaders):
        raise GameError(-44, "team/leader mismatch")
    for grid, leader in zip(teams, leaders):
        _validate_formation(ctx, leader, grid)
    _teams(ctx)[name] = {"teams": teams, "leaders": leaders}
    ctx.save()
    return 0


@route(13, 23)  # USE_TEAM: load a saved team into the formation groups
def use_team(ctx: Context, req: dict):
    team = _teams(ctx).get(str(req.get("name") or ""))
    if team is None:
        raise GameError(TEAM_NOT_EXIST, "team not exist")
    for index, (grid, leader) in enumerate(zip(team["teams"], team["leaders"]), start=1):
        group = _group(ctx, index)
        present = [[v if v and ctx.card(v) else 0 for v in row] for row in grid]
        _set_formation(ctx, group, leader if ctx.card(leader) else 0, present)
    return 0


@route(13, 24)  # UPDATE_TEAM_NAME
def update_team_name(ctx: Context, req: dict):
    teams = _teams(ctx)
    old, new = str(req.get("oldName") or ""), str(req.get("newName") or "").strip()
    if old not in teams:
        raise GameError(TEAM_NOT_EXIST, "team not exist")
    if not new:
        raise GameError(EMPTY_NAME, "empty name")
    if new in teams and new != old:
        raise GameError(-49, "name repeat")
    teams[new] = teams.pop(old)
    ctx.save()
    return 0


@route(13, 25)  # GET_TEAM_INFO
def get_team_info(ctx: Context, req: dict):
    teams = _teams(ctx)
    return {
        "teamLeaders": {name: [long_id(v) for v in t["leaders"]] for name, t in teams.items()},
        "teams": {name: [[[long_id(v) for v in row] for row in grid] for grid in t["teams"]]
                  for name, t in teams.items()},
    }
