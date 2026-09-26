"""MsgItem (mod 12): bag, fragment compose, selling and race swap."""

from __future__ import annotations

from ..defaults import long_id
from ..game import Context, GameError, as_id, parse_json, route

ARGUMENT_ILLEGAL = -1
ITEM_NOT_FOUND = -2
SELL_NOT_ALLOWED = -3
AMOUNT_NOT_ENOUGH = -4
CARD_IS_NOT_EXIST = -8
NO_RELATIVE_DES_CARD = -11
PLAYER_LEVEL_IS_NOT_ENOUGH_TO_SWAP = -12
FRAGMENT_NOT_ENOUGH = -13
DES_HERO_RACE_IS_NOT_MATCH = -14

RACE_PREFIX = {0: "yao", 1: "xian", 2: "ling"}  # UnitRace ordinal -> SwapCardSetting column


def item_vo(ctx: Context, item: dict) -> dict:
    return {"id": long_id(int(item["id"])), "baseId": int(item["base_id"]),
            "amount": int(item["amount"]), "type": int(item.get("type", 0)),
            "owner": long_id(ctx.player_id), "content": ""}


def _item(ctx: Context, value) -> dict:
    item = ctx.item(as_id(value))
    if item is None:
        raise GameError(ITEM_NOT_FOUND, "item not found")
    return item


@route(12, 1)  # GET_ITEMS
def get_items(ctx: Context, req: dict):
    return [item_vo(ctx, item) for item in ctx.items]


@route(12, 2)  # COMPOSE_ITEM: fragments -> reward (ComposeConfig keyed by fragment baseId)
def compose_item(ctx: Context, req: dict):
    item = _item(ctx, req.get("itemId"))
    row = ctx.config.index("ComposeConfig").get(int(item["base_id"]))
    if row is None:
        raise GameError(ARGUMENT_ILLEGAL, "not composable")
    need = int(row.get("amount") or 1)
    have = int(item["amount"])
    ledger = ctx.ledger()
    missing = max(0, need - have)
    if missing:
        # 推测值: "extend" tops up at most extendMax missing fragments with the
        # extendType currency at extendCost each.
        if not req.get("extend") or missing > int(row.get("extendMax") or 0):
            raise GameError(AMOUNT_NOT_ENOUGH, "fragments missing")
        for kind in parse_json(row.get("extendType"), ["FRAGMENT"]):
            ledger.pay_currency(kind, missing * int(row.get("extendCost") or 0))
    for kind in parse_json(row.get("costType"), ["COPPER"]):
        ledger.pay_currency(kind, int(row.get("cost") or 0))
    ledger.remove_item(item, need - missing, cost_type=1 + int(item.get("type", 0)))
    ledger.grant_reward_id(row.get("rewardId"))
    return ledger.cost_and_reward()


def _sell(ctx: Context, item: dict, amount: int) -> int:
    row = ctx.config.index("ItemConfig").get(int(item["base_id"])) or {}
    if not int(row.get("sell", 1)):
        raise GameError(SELL_NOT_ALLOWED, "cannot sell")
    if amount <= 0 or amount > int(item["amount"]):
        raise GameError(AMOUNT_NOT_ENOUGH, "amount")
    ctx.ledger().remove_item(item, amount, cost_type=1 + int(item.get("type", 0)))
    return amount * int(row.get("sellPrice") or 0)


@route(12, 3)  # SELL_ITEM
def sell_item(ctx: Context, req: dict):
    copper = _sell(ctx, _item(ctx, req.get("itemId")), int(req.get("amount") or 0))
    ledger = ctx.ledger()
    if copper:
        ledger.grant({"type": "CURRENCY", "code": 0, "amount": copper})
    return ledger.cost_and_reward()


@route(12, 4)  # SELL_ITEMS {itemId: amount}
def sell_items(ctx: Context, req: dict):
    mapping = req.get("_") if "_" in req else req
    copper = 0
    for item_id, amount in (mapping or {}).items():
        copper += _sell(ctx, _item(ctx, item_id), int(amount))
    ledger = ctx.ledger()
    if copper:
        ledger.grant({"type": "CURRENCY", "code": 0, "amount": copper})
    return ledger.cost_and_reward()


@route(12, 5)  # SWAP: trade a card for another race's card (SwapCardSetting)
def swap(ctx: Context, req: dict):
    card = ctx.card(as_id(req.get("cardId")))
    if card is None:
        raise GameError(CARD_IS_NOT_EXIST, "card missing")
    row = ctx.config.index("SwapCardSetting").get(int(card["base_id"]))
    if row is None:
        raise GameError(NO_RELATIVE_DES_CARD, "no swap config")
    prefix = RACE_PREFIX.get(int(req.get("unitRace") or 0))
    ids = parse_json(row.get(f"{prefix}Ids"), [])
    target = int(req.get("desBaseId") or 0)
    if target not in ids:
        raise GameError(DES_HERO_RACE_IS_NOT_MATCH, "target not in race list")
    index = ids.index(target)
    fragments = parse_json(row.get(f"{prefix}Fragments"), [0])[index]
    copper = parse_json(row.get(f"{prefix}Costs"), [0])[index]
    ledger = ctx.ledger()
    ledger.pay_currency("FRAGMENT", int(fragments))
    ledger.pay_currency("COPPER", int(copper))
    card["base_id"] = target
    ctx.save()
    return {"costResults": ledger.costs, "heroVo": ctx.hero_vo(card)}
