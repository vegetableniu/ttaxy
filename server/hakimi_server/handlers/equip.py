"""MsgEquip (mod 56): accessories (饰品) worn by hero cards.

Rules from BaseEquip (positions, equipTypes, fragments, nextId/materials/cost)
and ConfigValue EQUIP:* (pack size 99, +5 per extension, max 2 per hero).
"""

from __future__ import annotations

from ..defaults import long_id
from ..game import Context, GameError, as_id, parse_json, route

MATERIALS = ["PURPLE", "ORANGE", "RED"]
ARGUMENT_ILLEGAL = -1
NOT_FOUND = -2
POSITION_ERROR = -3
TYPE_NOT_MATCH = -4
PACK_FULL = -5
MATERIAL_NOT_ENOUGH = -6
FRAGMENT_NOT_ENOUGH = -7
MAX_LEVEL = -8
# 推测值: extension price (the PackExtendCost table cannot be told apart from
# six other id/cost tables in db.dat).
EXTEND_COST_GOLD = 50


def equips(ctx: Context) -> list[dict]:
    return ctx.state.setdefault("equips", [])


def equip_vo(ctx: Context, equip: dict) -> dict:
    return {"id": long_id(int(equip["id"])), "baseId": int(equip["base_id"]),
            "equipHero": long_id(int(equip.get("hero", 0))),
            "owner": long_id(ctx.player_id), "position": int(equip.get("position", 0))}


def pack_capacity(ctx: Context) -> int:
    return int(ctx.config.value("EQUIP:INIT_PACK_CAPACITY", 99)) \
        + int(ctx.state.get("equip_extend", 0)) * int(ctx.config.value("EQUIP:PACK_EXTEND_SPACE", 5))


def grant_equipment(ctx: Context, ledger, base_id: int) -> dict:
    if len(equips(ctx)) >= pack_capacity(ctx):
        raise GameError(PACK_FULL, "equipment pack full")
    equip = {"id": ctx.next_uid(), "base_id": base_id, "hero": 0, "position": 0}
    equips(ctx).append(equip)
    ctx.save()
    ledger._result("EQUIPMENT", base_id, 1, [equip_vo(ctx, equip)])
    return equip


def _equip(ctx: Context, value) -> dict:
    equip_id = as_id(value)
    for equip in equips(ctx):
        if int(equip["id"]) == equip_id:
            return equip
    raise GameError(NOT_FOUND, "equipment not found")


def _base(ctx: Context, equip: dict) -> dict:
    return ctx.config.index("BaseEquip").get(int(equip["base_id"]), {})


def _materials(ctx: Context) -> dict:
    return ctx.state.setdefault("equip_materials", {})


def _fragments(ctx: Context) -> dict:
    return ctx.state.setdefault("equip_fragments", {})


@route(56, 1)  # LOAD_ALL_EQUIPS (equipment list arrives with LoginInfo.equipVos)
def load_all_equips(ctx: Context, req: dict):
    return None


@route(56, 6)  # LOAD_EQUIP_PACK
def load_equip_pack(ctx: Context, req: dict):
    return {"extendCount": int(ctx.state.get("equip_extend", 0)),
            "extendLimit": int(ctx.config.value("EQUIP:PACK_EXTEND_COUNT_LIMIT", 40)),
            "fragments": {int(k): int(v) for k, v in _fragments(ctx).items()},
            "materials": {int(k): int(v) for k, v in _materials(ctx).items()},
            "usedSpace": len(equips(ctx))}


@route(56, 2)  # EQUIP {hero, id, position}
def equip(ctx: Context, req: dict):
    item = _equip(ctx, req.get("id"))
    hero_id, position = as_id(req.get("hero")), int(req.get("position") or 0)
    card = ctx.require_card(hero_id, NOT_FOUND)
    base = _base(ctx, item)
    if position not in parse_json(base.get("positions"), []):
        raise GameError(POSITION_ERROR, "wrong position")
    hero_type = ctx.config.heroes.get(int(card["base_id"]), {}).get("type")
    if hero_type not in parse_json(base.get("equipTypes"), []):
        raise GameError(TYPE_NOT_MATCH, "unit type mismatch")
    lock = ctx.config.index("EquipLockSetting").get(position, {}).get("lockKey")
    if lock and ctx.level < int(ctx.config.index("Lock").get(lock, {}).get("level") or 0):
        raise GameError(POSITION_ERROR, "position locked")
    for other in equips(ctx):  # one item per slot: replace
        if int(other.get("hero", 0)) == hero_id and int(other.get("position", 0)) == position:
            other.update(hero=0, position=0)
    item.update(hero=hero_id, position=position)
    ctx.save()
    return equip_vo(ctx, item)


@route(56, 7)  # UNEQUIP_POSITION
def unequip(ctx: Context, req: dict):
    item = _equip(ctx, req.get("equipId"))
    item.update(hero=0, position=0)
    ctx.save()
    return True


@route(56, 3)  # COMPOSE {baseId}: fragments -> equipment
def compose(ctx: Context, req: dict):
    base = ctx.config.index("BaseEquip").get(int(req.get("baseId") or 0))
    if base is None:
        raise GameError(ARGUMENT_ILLEGAL, "unknown equipment")
    code, need = str(base["fragmentCode"]), int(base["fragments"])
    if int(_fragments(ctx).get(code, 0)) < need:
        raise GameError(FRAGMENT_NOT_ENOUGH, "fragments")
    _fragments(ctx)[code] = int(_fragments(ctx)[code]) - need
    item = grant_equipment(ctx, ctx.ledger(), int(base["id"]))
    return {"baseid": int(base["id"]), "fragments": int(_fragments(ctx)[code]),
            "id": long_id(int(item["id"]))}


@route(56, 8)  # UPGRADE {id}: -> nextId using purple/orange materials + copper
def upgrade(ctx: Context, req: dict):
    item = _equip(ctx, req.get("id"))
    base = _base(ctx, item)
    if not int(base.get("nextId") or 0):
        raise GameError(MAX_LEVEL, "max level")
    need = parse_json(base.get("materials"), {})
    have = _materials(ctx)
    for name, amount in need.items():
        if int(have.get(str(MATERIALS.index(name)), 0)) < int(amount):
            raise GameError(MATERIAL_NOT_ENOUGH, "materials")
    ledger = ctx.ledger()
    ledger.pay_currency("COPPER", int(base.get("cost") or 0))
    for name, amount in need.items():
        key = str(MATERIALS.index(name))
        have[key] = int(have[key]) - int(amount)
    item["base_id"] = int(base["nextId"])
    ctx.save()
    return {"costResults": ledger.costs, "equipVo": equip_vo(ctx, item),
            "materials": {int(k): int(v) for k, v in have.items()}}


@route(56, 4)  # MELT {ids, materials}: equipment -> materials
def melt(ctx: Context, req: dict):
    ledger = ctx.ledger()
    have = _materials(ctx)
    for value in req.get("ids") or []:
        item = _equip(ctx, value)
        if int(item.get("hero", 0)):
            raise GameError(ARGUMENT_ILLEGAL, "equipment is worn")
        base = _base(ctx, item)
        equips(ctx).remove(item)
        # 推测值: melting refunds 60% of the purple/orange spent on upgrades
        # plus a rank-based base amount.
        refund = {"PURPLE": 20 * int(base.get("rank") or 1)}
        for name, amount in parse_json(base.get("materials"), {}).items():
            refund[name] = refund.get(name, 0) + int(int(amount) * 0.6)
        for name, amount in refund.items():
            key = str(MATERIALS.index(name))
            have[key] = int(have.get(key, 0)) + amount
            ledger._result("EQUIPMENT_MATERIAL", MATERIALS.index(name), amount, {})
    ctx.save()
    return ledger.rewards


def _buy_space(ctx: Context, currency: str, amount: int):
    if int(ctx.state.get("equip_extend", 0)) >= int(ctx.config.value("EQUIP:PACK_EXTEND_COUNT_LIMIT", 40)):
        raise GameError(PACK_FULL, "extension limit")
    ledger = ctx.ledger()
    if currency == "JADE":
        ledger.pay_jade(amount)
    else:
        ledger.pay_currency(currency, amount)
    ctx.state["equip_extend"] = int(ctx.state.get("equip_extend", 0)) + 1
    ctx.save()
    return ledger.costs


@route(56, 5)  # BUY_EQUIP_PACK_SPACE
def buy_space(ctx: Context, req: dict):
    return _buy_space(ctx, "JADE", EXTEND_COST_GOLD)


@route(56, 9)  # BUY_EQUIP_PACK_SPACE_BY_COUPON
def buy_space_coupon(ctx: Context, req: dict):
    return _buy_space(ctx, "COUPON", int(ctx.config.value("EQUIP:BUY_PACK_CAPACITY_BY_COUPON_COST", 1)))
