"""Shared game-domain machinery: command registry, player state, rewards.

Every business handler is a function registered with ``@route(mod, cmd)``.
It receives a :class:`Context` (session, account state, config) and the
decoded request, and returns the response ``content``.  Raising
:class:`GameError` answers with the original negative result code and
discards all state changes of the request (atomicity).

Reward/cost payloads follow the stock client exactly (see
``Logic/Reward.AddOneReward`` and ``Logic/Cost.Costs`` in script.dat):
  EXP          contents {level, exp}
  CURRENCY     code = CurrencyType ordinal, amount = delta
  ITEM/EQUIP/FRAGMENT  contents = [ItemInfo{type ADD|ALTER|REMOVE, id, itemType, amount, baseId}]
  HERO/EXP_CARD/COIN_CARD/TREASURE  contents = HeroVo (one result per card)
  ACTION_POINT code 0  contents {point, refreshTime}
"""

from __future__ import annotations

import copy
import json
import math
import time
from dataclasses import dataclass, field
from typing import Any, Callable

from .defaults import default_object, long_id


# ---------------------------------------------------------------- enums
CURRENCY = ["COPPER", "GOLD", "GIFT", "INTER", "EXCHANGE", "FRIENDSHIP",
            "FRAGMENT", "STONE", "CONSUME", "COUPON", "PURPLE", "ORANGE", "EXPLOIT"]
WALLET_KEYS = {"COPPER": "copper", "GOLD": "gold", "GIFT": "gift", "INTER": "inter",
               "FRIENDSHIP": "friendship", "FRAGMENT": "fragment", "STONE": "stone",
               "COUPON": "coupon", "PURPLE": "purple", "ORANGE": "orange",
               "EXPLOIT": "exploit"}
REWARD_TYPES = ["EXP", "CURRENCY", "ITEM", "EQUIP", "FRAGMENT", "HERO", "EXP_CARD",
                "COIN_CARD", "TREASURE", "ACTION_POINT", "VIP_TIME", "BUFF",
                "LEADERSHIP", "DEMOG_FRAGMENT", "REAL_GOODS", "SOUL_STONE",
                "TOKEN_COIN", "ARENA_INTEGRAL", "TALISMAN_FRAGMENT", "TALISMAN",
                "MENPAI_EXP", "EGG_HAMMER", "BOX_KEY", "TREASURE_ROOM_CURRENCY",
                "JIPING", "MENPAI_MONEY", "SECRETSHOP_CURRENCY", "EQUIPMENT",
                "EQUIPMENT_FRAGMENT", "EQUIPMENT_MATERIAL", "FOOTBALL", "MOON",
                "MONOPOLY", "TALISMAN_LIEBI", "SLOT_LOTTERY_TIMES", "SWEET",
                "CULTIVATE_ELIXIR", "CULTIVATE_MATERIAL", "TURKEY",
                "EXPLORE_NPC_EXP", "NEW_MONOPOLY", "SPRING"]
COST_TYPES = ["CURRENCY", "ITEM", "EQUIP", "FRAGMENT", "ACTION_POINT", "HERO",
              "DEMOG_FRAGMENT", "VIP_TIME", "MENPAI_MONEY", "MOON", "SWEET",
              "TURKEY", "TALISMAN", "EQUIPMENT"]
ITEM_TYPES = ["ITEM", "EQUIP", "FRAGMENT"]
CARD_REWARDS = {"HERO", "EXP_CARD", "COIN_CARD", "TREASURE"}
ITEM_ADD, ITEM_ALTER, ITEM_REMOVE = 0, 1, 2

# Result codes shared by many modules (com.eyu.mt.module.*.facade.*Result).
COPPER_NOT_ENOUGH = -100
GOLD_NOT_ENOUGH = -101


class GameError(Exception):
    """A rule violation answered with the original negative result code."""

    def __init__(self, code: int, message: str = ""):
        super().__init__(message or f"game error {code}")
        self.code = code


# ------------------------------------------------------------- registry
ROUTES: dict[tuple[int, int], Callable[["Context", dict], Any]] = {}


def route(mod: int, cmd: int):
    def register(function):
        ROUTES[(mod, cmd)] = function
        return function
    return register


def now_ms() -> int:
    return int(time.time() * 1000)


def parse_json(value: Any, default: Any) -> Any:
    if isinstance(value, (list, dict)):
        return value
    if value in (None, ""):
        return default
    try:
        return json.loads(value)
    except (TypeError, ValueError):
        return default


def as_id(value: Any) -> int:
    """Decode a Lua ``long`` (bytes) or plain number into an int."""
    if isinstance(value, (bytes, bytearray)):
        from .battle import decode_long_id
        return decode_long_id(bytes(value))
    return int(value or 0)


# --------------------------------------------------------------- context
@dataclass
class Context:
    server: Any
    account: str
    record: Any
    state: dict
    dirty: bool = False
    _ledger: "Ledger | None" = field(default=None, repr=False)

    @property
    def schema(self):
        return self.server.schema

    @property
    def config(self):
        return self.server.game_config

    @property
    def player_id(self) -> int:
        return int(self.record.player_id)

    def save(self) -> None:
        self.dirty = True

    def obj(self, type_name: str) -> dict:
        return default_object(self.schema, type_name)

    def ledger(self) -> "Ledger":
        if self._ledger is None:
            self._ledger = Ledger(self)
        return self._ledger

    # ---- player -----------------------------------------------------
    @property
    def player(self) -> dict:
        return self.state.setdefault("player", {"level": 1, "exp": 0})

    @property
    def level(self) -> int:
        return int(self.player.get("level", 1))

    @property
    def wallet(self) -> dict:
        return self.state.setdefault("wallet", {})

    def counter(self, name: str, default: int = 0) -> int:
        return int(self.state.setdefault("counters", {}).get(name, default))

    def add_counter(self, name: str, delta: int) -> int:
        counters = self.state.setdefault("counters", {})
        counters[name] = int(counters.get(name, 0)) + int(delta)
        self.save()
        return counters[name]

    def next_uid(self) -> int:
        """Unique id for cards/items/equipment owned by this player."""
        uid = int(self.state.get("next_uid", 0)) or self.player_id * 1000
        self.state["next_uid"] = uid + 1
        return uid + 1

    # ---- cards --------------------------------------------------------
    @property
    def cards(self) -> list[dict]:
        return ensure_cards(self.record, self.state, self.config)

    def card(self, card_id: int) -> dict | None:
        return next((c for c in self.cards if int(c["id"]) == card_id), None)

    def require_card(self, card_id: int, missing_code: int = -1) -> dict:
        card = self.card(card_id)
        if card is None:
            raise GameError(missing_code, f"card {card_id} not owned")
        return card

    def new_card(self, base_id: int, level: int = 1) -> dict:
        info = self.config.heroes.get(base_id, {})
        card = {
            "id": self.next_uid(),
            "base_id": base_id,
            "level": level,
            "exp": 0,
            "locked": False,
            "power_skill": int(parse_json(info.get("powerSkill"), 0) or 0),
            "skill_exp": 0,
        }
        self.cards.append(card)
        self.save()
        return card

    def remove_card(self, card_id: int) -> None:
        cards = self.cards
        cards[:] = [c for c in cards if int(c["id"]) != card_id]
        self.save()

    def hero_vo(self, card: dict) -> dict:
        return hero_vo(self.schema, card)

    @property
    def groups(self) -> dict:
        return ensure_groups(self.record, self.state)

    def cards_in_use(self) -> set[int]:
        used = set()
        for group in self.groups["groups"]:
            used.add(int(group["leaderId"]))
            for row in group["embattles"]:
                used.update(int(v) for v in row if int(v))
        return used

    # ---- items --------------------------------------------------------
    @property
    def items(self) -> list[dict]:
        return self.state.setdefault("items", [])

    def item(self, item_id: int) -> dict | None:
        return next((i for i in self.items if int(i["id"]) == item_id), None)

    def item_amount(self, base_id: int) -> int:
        return sum(int(i["amount"]) for i in self.items if int(i["base_id"]) == base_id)


def ensure_cards(record, state: dict, config) -> list[dict]:
    """All owned cards, including the starter leader (migrates old saves)."""
    cards = state.get("cards")
    if cards is None:
        starter_info = config.heroes.get(int(record.starter_hero), {})
        cards = [{
            "id": int(record.hero_id),
            "base_id": int(record.starter_hero),
            "level": 1, "exp": 0, "locked": False,
            "power_skill": int(parse_json(starter_info.get("powerSkill"), 0) or 0),
            "skill_exp": 0,
        }]
        for old in state.pop("heroes", []) or []:
            cards.append(dict(old))
        state["cards"] = cards
        top = max(int(c["id"]) for c in cards)
        state["next_uid"] = max(int(state.get("next_uid", 0)), top, int(record.player_id) * 1000)
    return cards


def ensure_groups(record, state: dict) -> dict:
    groups = state.get("groups")
    if groups is None:
        leader = int(record.hero_id)
        groups = {"curGroupId": 1, "groups": [
            {"groupId": gid, "leaderId": leader if gid == 1 else 0,
             "embattles": [[leader if gid == 1 else 0, 0], [0, 0], [0, 0]]}
            for gid in (1, 2, 3)
        ]}
        state["groups"] = groups
    return groups


def hero_vo(schema, card: dict) -> dict:
    value = default_object(schema, "com.eyu.mt.module.hero.model.HeroVo")
    value.update(
        id=long_id(int(card["id"])),
        baseId=int(card["base_id"]),
        exp=int(card.get("exp", 0)),
        level=int(card.get("level", 1)),
        locked=bool(card.get("locked", False)),
        powerSkill=int(card.get("power_skill", 0)),
        skillExp=int(card.get("skill_exp", 0)),
    )
    return value


def group_vo(group: dict) -> dict:
    return {
        "groupId": int(group["groupId"]),
        "leaderId": long_id(int(group["leaderId"])),
        "embattles": [[long_id(int(v)) for v in row] for row in group["embattles"]],
    }


def embattle_ids(value: Any) -> list[list[int]]:
    return [[as_id(v) for v in row] for row in (value or [])]


def normalize_spec(spec: dict) -> dict:
    """Accept config-style ``{"type":"CURRENCY","code":0,"amount":5}`` specs."""
    kind = spec.get("type")
    if isinstance(kind, int):
        kind = REWARD_TYPES[kind]
    code = spec.get("code", 0)
    if isinstance(code, str) and not code.lstrip("-").isdigit():
        code = CURRENCY.index(code) if code in CURRENCY else 0
    return {"type": str(kind), "code": int(code or 0), "amount": int(spec.get("amount", 1))}


# ---------------------------------------------------------------- ledger
class Ledger:
    """Accumulates CostResult/RewardResult entries for one request."""

    def __init__(self, ctx: Context):
        self.ctx = ctx
        self.costs: list[dict] = []
        self.rewards: list[dict] = []

    def cost_and_reward(self) -> dict:
        return {"costs": self.costs, "rewards": self.rewards}

    # ---- currency -----------------------------------------------------
    def _currency_key(self, code: int) -> str:
        return CURRENCY[code]

    def balance(self, code: int) -> int:
        name = self._currency_key(code)
        if name in WALLET_KEYS:
            return int(self.ctx.wallet.get(WALLET_KEYS[name], 0))
        return self.ctx.counter("currency_" + name)

    def _change_currency(self, code: int, delta: int) -> None:
        name = self._currency_key(code)
        if name in WALLET_KEYS:
            key = WALLET_KEYS[name]
            self.ctx.wallet[key] = int(self.ctx.wallet.get(key, 0)) + delta
        else:
            self.ctx.add_counter("currency_" + name, delta)
        if name == "GOLD" and delta < 0:
            self.ctx.add_counter("gold_consumed", -delta)
        self.ctx.save()

    def pay_currency(self, code: int | str, amount: int) -> None:
        if isinstance(code, str):
            code = CURRENCY.index(code)
        amount = int(amount)
        if amount <= 0:
            return
        if self.balance(code) < amount:
            raise GameError(-100 - code if code <= 8 else -105,
                            f"{CURRENCY[code]} not enough")
        self._change_currency(code, -amount)
        self.costs.append({"type": 0, "code": code, "amount": -amount, "contents": None})

    def pay_costs(self, specs: list[dict]) -> None:
        """Pay a config cost list such as ``costItems`` (all-or-nothing by caller)."""
        for raw in specs:
            spec = normalize_spec(raw)
            if spec["type"] == "CURRENCY":
                self.pay_currency(spec["code"], spec["amount"])
            elif spec["type"] in ("ITEM", "FRAGMENT", "EQUIP"):
                self.pay_item_base(spec["code"], spec["amount"])
            elif spec["type"] == "ACTION_POINT":
                self.pay_action_point(spec["amount"])
            else:
                raise GameError(-1, f"unsupported cost {spec}")

    # ---- items --------------------------------------------------------
    def _item_info(self, kind: int, item: dict, amount: int) -> dict:
        return {"type": kind, "id": long_id(int(item["id"])),
                "itemType": int(item.get("type", 0)), "amount": amount,
                "baseId": int(item["base_id"]), "content": ""}

    def add_item(self, base_id: int, amount: int, item_type: int | None = None) -> list[dict]:
        if item_type is None:
            item_type = item_type_of(self.ctx.config, base_id)
        infos = []
        existing = next((i for i in self.ctx.items if int(i["base_id"]) == base_id), None)
        if existing is not None:
            existing["amount"] = int(existing["amount"]) + amount
            infos.append(self._item_info(ITEM_ALTER, existing, amount))
        else:
            item = {"id": self.ctx.next_uid(), "base_id": base_id, "type": item_type,
                    "amount": amount}
            self.ctx.items.append(item)
            infos.append(self._item_info(ITEM_ADD, item, amount))
        self.ctx.save()
        return infos

    def remove_item(self, item: dict, amount: int, cost_type: int = 1) -> None:
        if int(item["amount"]) < amount or amount <= 0:
            raise GameError(-5, "item not enough")
        item["amount"] = int(item["amount"]) - amount
        kind = ITEM_ALTER
        if item["amount"] <= 0:
            self.ctx.items.remove(item)
            kind = ITEM_REMOVE
        self.ctx.save()
        self.costs.append({"type": cost_type, "code": int(item["base_id"]), "amount": -amount,
                           "contents": [self._item_info(kind, item, -amount)]})

    def pay_item_base(self, base_id: int, amount: int) -> None:
        if self.ctx.item_amount(base_id) < amount:
            raise GameError(-5, f"item {base_id} not enough")
        for item in [i for i in self.ctx.items if int(i["base_id"]) == base_id]:
            take = min(amount, int(item["amount"]))
            self.remove_item(item, take, cost_type=1 + int(item.get("type", 0)))
            amount -= take
            if amount <= 0:
                break

    # ---- cards --------------------------------------------------------
    def pay_card(self, card: dict) -> None:
        card_id = int(card["id"])
        if bool(card.get("locked")):
            raise GameError(-10, "card is locked")
        if card_id in self.ctx.cards_in_use():
            raise GameError(-9, "card is in use")
        self.ctx.remove_card(card_id)
        self.costs.append({"type": 5, "code": int(card["base_id"]), "amount": -1,
                           "contents": {"id": long_id(card_id)}})

    # ---- action points -------------------------------------------------
    def pay_action_point(self, amount: int, kind: int = 0) -> None:
        points = self.ctx.state.setdefault("action_points", {})
        current = int(points.get(str(kind), 0))
        if current < amount:
            raise GameError(-2, "action point not enough")
        points[str(kind)] = current - amount
        self.ctx.save()
        self.costs.append({"type": 4, "code": kind, "amount": -amount,
                           "contents": {"point": points[str(kind)], "refreshTime": now_ms()}})

    # ---- rewards ------------------------------------------------------
    def _result(self, kind: str, code: int, amount: int, contents: Any) -> dict:
        result = {"additionRate": {}, "amount": amount, "code": code,
                  "contents": contents, "mail": False, "type": REWARD_TYPES.index(kind)}
        self.rewards.append(result)
        return result

    def grant(self, raw: dict) -> list[dict]:
        spec = normalize_spec(raw)
        kind, code, amount = spec["type"], spec["code"], spec["amount"]
        ctx = self.ctx
        if kind == "EXP":
            add_player_exp(ctx, amount)
            return [self._result(kind, code, amount,
                                 {"level": ctx.level, "exp": int(ctx.player["exp"])})]
        if kind == "CURRENCY":
            self._change_currency(code, amount)
            return [self._result(kind, code, amount, {})]
        if kind in ("ITEM", "EQUIP", "FRAGMENT"):
            infos = self.add_item(code, amount, ITEM_TYPES.index(kind))
            return [self._result(kind, code, amount, infos)]
        if kind in CARD_REWARDS:
            return [self._result(kind, code, 1, ctx.hero_vo(ctx.new_card(code)))
                    for _ in range(max(1, amount))]
        if kind == "ACTION_POINT":
            points = ctx.state.setdefault("action_points", {})
            points[str(code)] = int(points.get(str(code), 0)) + amount
            ctx.save()
            return [self._result(kind, code, amount,
                                 {"point": points[str(code)], "refreshTime": now_ms()})]
        # Counters consumed by their own modules (token coin, box keys, ...).
        ctx.add_counter(f"reward_{kind}_{code}", amount)
        return [self._result(kind, code, amount, {})]

    def grant_all(self, specs: list[dict]) -> None:
        for spec in specs:
            self.grant(spec)

    def grant_reward_id(self, reward_id: str) -> None:
        self.grant_all(reward_specs(self.ctx.config, reward_id))


def reward_specs(config, reward_id: str) -> list[dict]:
    row = config.index("RewardConfig").get(str(reward_id))
    if row is None:
        return []
    return list(parse_json(row.get("fixed"), []))


def item_type_of(config, base_id: int) -> int:
    row = config.index("ItemConfig").get(base_id)
    kind = (row or {}).get("type", "ITEM")
    return ITEM_TYPES.index(kind) if kind in ITEM_TYPES else 0


def add_player_exp(ctx: Context, amount: int) -> None:
    player = ctx.player
    player["exp"] = int(player.get("exp", 0)) + int(amount)
    levels = ctx.config.levels
    while player["level"] in levels:
        need = int(levels[player["level"]].get("exp") or 0)
        if need <= 0 or player["exp"] < need or player["level"] + 1 not in levels:
            break
        player["exp"] -= need
        player["level"] += 1
    ctx.save()


def snapshot(state: dict) -> dict:
    return copy.deepcopy(state)


def floor(value: float) -> int:
    return int(math.floor(value + 1e-9))
