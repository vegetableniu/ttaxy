"""Mall page (GET_LOTTERY_LIST) and card draws (LOTTERY, EQUIP_LOTTERY).

The shop page is one server list of LotteryListVO rows; ``kind`` selects the
widget (Logic/Mall ITEM_KIND).  Pool ids/names/unlock levels come from the
client Lock table; pool contents come from BaseHero.gain.  Prices, weights and
the ten-draw guarantee are 推测值 (the original lottery tables were server-only).
"""

from __future__ import annotations

import json
import random

from ..settings import setting
from ..game import Context, GameError, now_ms, parse_json, route

LOTTERY_INVALID = -12
BLOCK_BY_LEVEL = -8
CARD_PACK_FULL = -9
LOTTERY_TIMES_LIMIT = -11

YEAR_MS = 365 * 86_400_000

def pools() -> list[tuple]:
    """(id, lotteryType, currency, price, filter) from server_settings.json lottery.pools."""
    out = []
    for p in setting("lottery.pools", []):
        spec = {k: p[k] for k in ("gain", "race", "extra_drop_max_star") if k in p}
        out.append((int(p["id"]), p["lotteryType"], p["currency"], int(p["price"]), spec))
    return out


def jade_weights() -> dict:
    return {int(k): int(v) for k, v in setting("lottery.star_weights", {"3": 1}).items()}


OTHER_KINDS = [  # mall widgets served by other commands
    (101, "BUY_POINTS", "购买体力"), (102, "BUY_BAG", "扩充卡包"),
    (103, "BUY_FRIEND", "扩充好友"), (410, "TOKEN_COIN", "代币兑换"),
    (500, "OPEN_BETA_GOODS", "超值商品"),
]


def _lock(ctx: Context, key: str) -> dict:
    return ctx.config.index("Lock").get(key, {})


def _pool_cards(ctx: Context, spec: dict) -> list[dict]:
    cards = [h for h in ctx.config.rows("BaseHero")
             if h["card"] == "HERO" and spec["gain"] in h["gain"]
             and ("race" not in spec or h["race"] == spec["race"])]
    if "extra_drop_max_star" in spec:
        cards += [h for h in ctx.config.rows("BaseHero")
                  if h["card"] == "HERO" and "关卡掉落" in h["gain"]
                  and int(h["star"]) <= spec["extra_drop_max_star"]]
    return cards


def _row(ctx: Context, pool) -> dict:
    pid, key, currency, price, spec = pool
    lock = _lock(ctx, key)
    cards = _pool_cards(ctx, spec)
    top = max(cards, key=lambda h: (int(h["star"]), int(h["id"])))
    now = now_ms()
    return {
        "id": pid, "kind": "LOTTERY", "type": key, "lotteryType": key,
        "title": lock.get("lotteryName", key), "description": lock.get("lotteryName", key),
        "baseId": int(top["id"]), "cardID": str(top["id"]), "cardLevel": "1",
        "cardTip": "", "cardType": "HERO", "desInPage": "[]", "path": "",
        "level": int(lock.get("level") or 1), "endLevel": 9999,
        "battle": lock.get("battle", ""), "eliteBattle": "", "activity": "",
        "activityCharge": 0, "playerActivityCharge": 0,
        "prices": json.dumps([price, price * 10]), "salePrices": [price, price * 10],
        "probability": json.dumps([{"baseId": int(h["id"]), "weight": 1} for h in cards]),
        "current": int(ctx.state.get("lottery_counts", {}).get(key, 0)),
        "usedFreeTimes": 0, "limits": 0, "weight": 0,
        "startTime": now - YEAR_MS, "endTime": now + YEAR_MS, "resetDate": now,
        "show": True, "showTemplete": "", "sort": pid, "sortType": "NORMAL",
        "vip": False, "week": False,
    }


def _other_row(ctx: Context, row_id: int, kind: str, title: str) -> dict:
    now = now_ms()
    return {
        "id": row_id, "kind": kind, "type": kind, "lotteryType": "", "title": title,
        "description": title, "baseId": 0, "cardID": "", "cardLevel": "", "cardTip": "",
        "cardType": "", "desInPage": "[]", "path": "", "level": 1, "endLevel": 9999,
        "battle": "", "eliteBattle": "", "activity": "", "activityCharge": 0,
        "playerActivityCharge": 0, "prices": "[]", "salePrices": [], "probability": "[]",
        "current": 0, "usedFreeTimes": 0, "limits": 0, "weight": 0,
        "startTime": now - YEAR_MS, "endTime": now + YEAR_MS, "resetDate": now,
        "show": True, "showTemplete": "", "sort": row_id, "sortType": "NORMAL",
        "vip": False, "week": False,
    }


@route(11, 11)  # GET_LOTTERY_LIST
def get_lottery_list(ctx: Context, req: dict):
    rows = [_row(ctx, pool) for pool in pools()]
    rows += [_other_row(ctx, *other) for other in OTHER_KINDS]
    return rows


def _draw_one(ctx: Context, cards: list[dict], jade: bool, guarantee: bool) -> int:
    if not jade:
        return int(random.choice(cards)["id"])
    by_star: dict[int, list[dict]] = {}
    for h in cards:
        by_star.setdefault(int(h["star"]), []).append(h)
    top = int(setting("lottery.ten_draw_guarantee_star", 7))
    if guarantee and top in by_star:
        return int(random.choice(by_star[top])["id"])
    weights = jade_weights()
    stars = [s for s in weights if s in by_star] or list(by_star)
    star = random.choices(stars, weights=[weights.get(s, 1) for s in stars])[0]
    return int(random.choice(by_star[star])["id"])


@route(11, 1)  # LOTTERY {id, time}: time = number of draws (1 or 10)
def lottery(ctx: Context, req: dict):
    pool = next((p for p in pools() if p[0] == int(req.get("id") or 0)), None)
    times = int(req.get("time") or 1)
    if pool is None or times not in (1, 10):
        raise GameError(LOTTERY_INVALID, "invalid lottery")
    pid, key, currency, price, spec = pool
    if ctx.level < int(_lock(ctx, key).get("level") or 1):
        raise GameError(BLOCK_BY_LEVEL, "level")
    from .hero import pack_limit
    if len(ctx.cards) + times > pack_limit(ctx):
        raise GameError(CARD_PACK_FULL, "card pack full")
    ledger = ctx.ledger()
    if currency == "FRIENDSHIP":
        ledger.pay_currency("FRIENDSHIP", price * times)
    else:
        ledger.pay_jade(price * times)
    cards = _pool_cards(ctx, spec)
    counts = ctx.state.setdefault("lottery_counts", {})
    guaranteed = times == 10 and currency == "JADE"
    lucky = random.randrange(times) if guaranteed else -1
    for index in range(times):
        base = _draw_one(ctx, cards, currency == "JADE", index == lucky)
        ledger.grant({"type": "HERO", "code": base, "amount": 1})
    counts[key] = int(counts.get(key, 0)) + times
    ctx.save()
    return ledger.cost_and_reward()


@route(11, 20)  # EQUIP_LOTTERY {free, id, time}: equipment packs (EquipLottery)
def equip_lottery(ctx: Context, req: dict):
    row = ctx.config.index("EquipLottery").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(LOTTERY_INVALID, "invalid equip lottery")
    state = ctx.state.setdefault("equip_lottery", {}).setdefault(str(row["id"]), {
        "current": 0, "free": 0, "reset": now_ms()})
    if now_ms() - int(state["reset"]) >= int(row["resetTimesHours"]) * 3_600_000:
        state.update(free=0, reset=now_ms())
    times = int(req.get("time") or 1)
    ledger = ctx.ledger()
    if req.get("free"):
        if int(state["free"]) >= int(row["resetTimes"]):
            raise GameError(-20, "no free draw")
        state["free"] = int(state["free"]) + 1
        times = 1
    else:
        ledger.pay_jade(int(setting("lottery.equip_pack_price", 100)) * times)
    equips = [e for e in ctx.config.rows("BaseEquip")]
    from .equip import grant_equipment
    for _ in range(times):
        state["current"] = int(state["current"]) + 1
        must = state["current"] >= int(row["mustOutTimes"])
        pool = [e for e in equips if not must or int(e.get("star", 0) or 0) >= 7] or equips
        grant_equipment(ctx, ledger, int(random.choice(pool)["id"]))
        if must:
            state["current"] = 0
    ctx.save()
    return {"current": int(state["current"]), "resetDate": int(state["reset"]),
            "result": ledger.cost_and_reward(), "usedFreeTimes": int(state["free"])}
