"""Remaining systems: 修行 cultivate (76), 探索 explore (86), 圣诞任务 task (48),
大富翁 monopoly (75) / new monopoly (87), dev commands fight (158) / reward (159).
Task pools, board layouts and odds the server kept private are 推测值."""

from __future__ import annotations

import random
import time

from ..bots import BOT_BASE, bot
from ..combat import MAJOR, MINOR, fight, make_fighter
from ..defaults import long_id
from ..game import Context, GameError, as_id, now_ms, parse_json, route
from .player import show_spec


def _today() -> str:
    return time.strftime("%Y%m%d")


# ------------------------------------------------------------- 76 cultivate
def _cult(ctx) -> dict:
    return ctx.state.setdefault("cultivate", {"elixirs": {}, "heroes": {}})


def _materials(ctx) -> dict:
    return {int(r["id"]): ctx.counter(f"reward_CULTIVATE_MATERIAL_{r['id']}")
            for r in ctx.config.rows("ElixirMaterial")}


@route(76, 1)
def cult_info(ctx, req):
    c = _cult(ctx)
    return {"elixires": {int(k): int(v) for k, v in c["elixirs"].items()}, "materials": _materials(ctx)}


@route(76, 2)  # COMPOUND_ELIXIR {id}
def cult_compound(ctx, req):
    row = ctx.config.index("ElixirSetting").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-1, "no elixir")
    for mid, n in parse_json(row["materials"], {}).items():
        if ctx.counter(f"reward_CULTIVATE_MATERIAL_{mid}") < int(n):
            raise GameError(-2, "materials")
    led = ctx.ledger()
    led.pay_currency("COPPER", int(row.get("cost") or 0))
    for mid, n in parse_json(row["materials"], {}).items():
        ctx.add_counter(f"reward_CULTIVATE_MATERIAL_{mid}", -int(n))
    c = _cult(ctx)
    c["elixirs"][str(row["id"])] = int(c["elixirs"].get(str(row["id"]), 0)) + 1
    ctx.save()
    return {"costResults": led.costs, "materials": _materials(ctx)}


@route(76, 3)  # SWALLOW_ELIXIR {elixirId, heroId, position}
def cult_swallow(ctx, req):
    c = _cult(ctx)
    eid = str(int(req.get("elixirId") or 0))
    if int(c["elixirs"].get(eid, 0)) <= 0:
        raise GameError(-3, "no elixir")
    hero = ctx.require_card(as_id(req.get("heroId")), -4)
    c["elixirs"][eid] = int(c["elixirs"][eid]) - 1
    slots = c["heroes"].setdefault(str(hero["id"]), {"state": 1, "elixirs": {}})
    slots["elixirs"][str(int(req.get("position") or 0))] = int(eid)
    ctx.save()
    return {int(k): int(v) for k, v in slots["elixirs"].items()}


@route(76, 4)  # RE_CULTIVATE {cost, heroId}: raise the card's 境界 (CultivateState)
def cult_re(ctx, req):
    c = _cult(ctx)
    hero = ctx.require_card(as_id(req.get("heroId")), -4)
    slots = c["heroes"].setdefault(str(hero["id"]), {"state": 1, "elixirs": {}})
    state = ctx.config.index("CultivateState").get(int(slots["state"]), {})
    if not int(state.get("nextId") or 0):
        raise GameError(-5, "max state")
    led = ctx.ledger()
    led.pay_currency("COPPER", int(state.get("cost") or 0))
    slots["state"] = int(state["nextId"])
    slots["elixirs"] = {}
    ctx.save()
    return {"costResults": led.costs, "rewardResults": []}


@route(76, 5)  # HERO_CROSSING {embattle, heroId}: 渡劫 vs UnitTypeElixir virtual fighter
def cult_crossing(ctx, req):
    hero = ctx.require_card(as_id(req.get("heroId")), -4)
    from .battle import card_fighter
    team = [card_fighter(ctx, 1, hero, MAJOR)]
    for r, row in enumerate(req.get("embattle") or []):
        for col, value in enumerate(row):
            card = ctx.card(int(value)) if str(value).isdigit() and int(value) else None
            if card and card is not hero:
                team.append(card_fighter(ctx, r * 2 + col, card, MINOR))
    level = int(hero.get("level", 1))
    enemy = [make_fighter(ctx.config, 7, int(hero["base_id"]), level + 10, MAJOR)]
    won, report = fight(ctx.config, team, enemy)
    return {"costResults": [], "reports": [report], "targetGroupNum": 1, "win": won}


# --------------------------------------------------------------- 86 explore
def _exp(ctx) -> dict:
    e = ctx.state.setdefault("explore", {"level": 1, "exp": 0, "releases": [], "executes": [],
                                         "refresh": 0, "day": "", "next": 1})
    if e["day"] != _today():
        e.update(day=_today(), refresh=0)
        e["releases"] = [_new_task(ctx, e) for _ in range(3)]
    return e


def _new_task(ctx, e) -> dict:
    star = random.randint(1, min(5, int(e["level"]) + 1))
    tid = int(e["next"])
    e["next"] = tid + 1
    return {"id": tid, "star": star, "minutes": random.choice([30, 60, 120, 180]),
            "cards": min(5, star + 1), "rate": 50 + star * 5}


def _release_vo(t) -> dict:
    return {"cardCount": t["cards"], "decreaseCD": 0, "exceTimes": t["minutes"], "id": long_id(t["id"]),
            "point": 100, "rate": t["rate"], "reward": t["star"], "star": t["star"], "successItems": []}


def _execute_vo(t) -> dict:
    return {"decreaseCD": 0, "endAt": t["end"], "exceTimes": t["minutes"], "fightScore": 0,
            "friendCards": [], "id": long_id(t["id"]), "point": 100, "rate": t["rate"],
            "reward": t["star"], "selfCards": [{"baseId": 0, "id": long_id(c), "owner": long_id(0), "score": 0}
                                               for c in t["cards_used"]],
            "star": t["star"], "successItems": [], "virtualCards": []}


@route(86, 1)
def explore_info(ctx, req):
    e = _exp(ctx)
    ctx.save()
    busy = [c for t in e["executes"] for c in t["cards_used"]]
    return {"costFinishTimes": 0, "costRefreshTimes": e["refresh"], "executeHeros": [long_id(c) for c in busy],
            "executes": [_execute_vo(t) for t in e["executes"]], "exp": e["exp"], "hireFriendTimes": 0,
            "hireVirtualTimes": 0, "level": e["level"], "nextRefresh": now_ms() + 6 * 3_600_000,
            "releases": [_release_vo(t) for t in e["releases"]]}


@route(86, 2)
def explore_refresh(ctx, req):
    e = _exp(ctx)
    costs = ctx.config.value("EXPLORE:REFRESH_COSTS", [50])
    led = ctx.ledger()
    led.pay_jade(int(costs[min(e["refresh"], len(costs) - 1)]))
    e["refresh"] += 1
    e["releases"] = [_new_task(ctx, e) for _ in range(3)]
    ctx.save()
    return {"costRefreshTimes": e["refresh"], "costResults": led.costs,
            "releases": [_release_vo(t) for t in e["releases"]]}


@route(86, 3)  # EXECUTE_TASK {selfs, taskId, ...}
def explore_execute(ctx, req):
    e = _exp(ctx)
    tid = as_id(req.get("taskId"))
    task = next((t for t in e["releases"] if t["id"] == tid), None)
    if task is None:
        raise GameError(-1, "no task")
    cards = [as_id(c.get("id")) for c in req.get("selfs") or [] if isinstance(c, dict)]
    e["releases"].remove(task)
    task.update(cards_used=cards, end=now_ms() + task["minutes"] * 60_000)
    e["executes"].append(task)
    ctx.save()
    return {"costResults": [], "executeHeros": [long_id(c) for c in cards],
            "executes": [_execute_vo(t) for t in e["executes"]], "hireFriendTimes": 0,
            "hireVirtualTimes": 0, "releases": [_release_vo(t) for t in e["releases"]]}


def _draw_explore(ctx, task_id: int, pay: bool):
    e = _exp(ctx)
    task = next((t for t in e["executes"] if t["id"] == task_id), None)
    if task is None:
        raise GameError(-1, "no task")
    led = ctx.ledger()
    if task["end"] > now_ms():
        if not pay:
            raise GameError(-2, "not finished")
        led.pay_jade(max(1, (task["end"] - now_ms()) // 60_000))
    e["executes"].remove(task)
    success = random.randint(1, 100) <= task["rate"]
    reward = ctx.config.index("TaskRewardConfig").get(-1, {})
    for kind, sid, n in zip(parse_json(reward.get("baseShowTypes"), []), parse_json(reward.get("baseShowIds"), []),
                            parse_json(reward.get("baseAmounts"), [])):
        if kind == "EXPLORE_NPC_EXP":
            e["exp"] += int(n) * task["star"]
        else:
            led.grant(show_spec(kind, sid, int(n) * task["star"]))
    if success:
        for kind, sid, n in zip(parse_json(reward.get("successShowTypes"), []),
                                parse_json(reward.get("successShowIds"), []),
                                parse_json(reward.get("successAmounts"), [])):
            led.grant(show_spec(kind, sid, n))
    ctx.save()
    busy = [c for t in e["executes"] for c in t["cards_used"]]
    return {"costResults": led.costs, "executeHeros": [long_id(c) for c in busy],
            "executes": [_execute_vo(t) for t in e["executes"]], "rewardResults": led.rewards,
            "success": success}


@route(86, 4)
def explore_finish_now(ctx, req):
    return _draw_explore(ctx, as_id(req.get("_")), True)


@route(86, 6)
def explore_draw(ctx, req):
    return _draw_explore(ctx, as_id(req.get("_")), False)


@route(86, 5)  # GET_FRIEND_CARDS
def explore_friends(ctx, req):
    out = []
    for fid in ctx.state.get("social", {}).get("friends", [])[:10]:
        b = bot(ctx.config, fid)
        out.append({"artifactLevel": 0, "baseId": b.leader, "cultivateVo": None, "equips": [],
                    "heroId": long_id(fid), "heroLevel": b.level, "id": long_id(fid), "level": b.level,
                    "name": b.name, "powerSkill": 0, "pvpDesId": 0, "score": b.power(ctx.config),
                    "talisman": [], "userBuffs": []})
    return out


def _npc(ctx) -> dict:
    e = _exp(ctx)
    return {"exp": e["exp"], "level": e["level"]}


@route(86, 7)  # UP_NPC_LEVEL: NPCLevelConfig
def explore_up(ctx, req):
    e = _exp(ctx)
    row = ctx.config.index("NPCLevelConfig").get(int(e["level"]), {})
    if e["exp"] < int(row.get("exp") or 10**9) or ctx.level < int(row.get("levelLimit") or 0):
        raise GameError(-3, "condition")
    e["exp"] -= int(row["exp"])
    e["level"] += 1
    ctx.save()
    return {"npcCurrentInfo": _npc(ctx), "releases": [_release_vo(t) for t in e["releases"]]}


@route(86, 8)  # OWNER_FIGHT_SCORE [ids]
def explore_scores(ctx, req):
    from ..combat import make_fighter as mf
    out = {}
    for value in req.get("_") or []:
        card = ctx.card(as_id(value))
        if card:
            f = mf(ctx.config, 0, int(card["base_id"]), int(card.get("level", 1)), MINOR)
            out[long_id(int(card["id"]))] = f.attack + f.max_hp // 10
    return out


@route(86, 9)  # BUY_NPC_EXP [times]
def explore_buy_exp(ctx, req):
    times = max(1, int(req.get("_") or 1))
    led = ctx.ledger()
    led.pay_jade(int(ctx.config.value("EXPLORE:BUY_EXP_COST_BASE", 100)) * times)
    _exp(ctx)["exp"] += int(ctx.config.value("EXPLORE:BUY_EXP_COUNT", 100)) * times
    ctx.save()
    return {"costResults": led.costs, "npcCurrentInfo": _npc(ctx)}


# --------------------------------------------------------------- 48 task (圣诞)
def _task(ctx) -> dict:
    t = ctx.state.setdefault("xmas", {"day": "", "tasks": [], "picked": [], "done": [], "got": [],
                                       "count": 0, "bought": 0, "refresh": 0, "cool": 0, "base": {}})
    if t["day"] != _today():
        t.update(day=_today(), done=[], got=[], count=0, bought=0, refresh=0)
        t["tasks"] = _pick_tasks(ctx)
    return t


def _pick_tasks(ctx) -> list:
    rows = [r["id"] for r in ctx.config.rows("TaskSetting")]
    return random.sample(rows, min(int(ctx.config.value("CHRISTMAS:REFRESH_TASKS_NUM", 3)), len(rows)))


def _clears(ctx) -> int:
    return sum(int(v) for v in ctx.state.get("daily_counts", {}).values())


def _targets(ctx, t) -> dict:
    return {str(k): float(_clears(ctx) - int(v)) for k, v in t["base"].items()}


def _open_vo(ctx, t) -> dict:
    return {"completeCount": t["count"], "completeTasks": t["done"], "coolState": t["cool"] > now_ms(),
            "coolTime": t["cool"], "gottask": t["got"], "pickUpTasks": t["picked"],
            "refreshCount": t["refresh"], "targetValues": _targets(ctx, t), "tasks": t["tasks"],
            "todayBuyCompleteCount": t["bought"], "totalCompleteCount": t["count"]}


@route(48, 1)
def task_open(ctx, req):
    t = _task(ctx)
    ctx.save()
    return _open_vo(ctx, t)


def _task_refresh(ctx, cost: int):
    t = _task(ctx)
    led = ctx.ledger()
    if cost:
        led.pay_jade(cost)
    t["tasks"] = _pick_tasks(ctx)
    t["refresh"] += 1
    ctx.save()
    return {"coolState": False, "coolTime": 0, "costResults": led.costs, "tasks": t["tasks"]}


@route(48, 2)
def task_free_refresh(ctx, req):
    return _task_refresh(ctx, 0)


@route(48, 3)
def task_refresh(ctx, req):
    return _task_refresh(ctx, int(ctx.config.value("CHRISTMAS:MAX_REFRESH_TIMES_COST", 100)))


@route(48, 7)
def task_adv_refresh(ctx, req):
    return _task_refresh(ctx, int(ctx.config.value("CHRISTMAS:ADVANCED_REFRESH_COST", 500)))


@route(48, 8)  # PICK_UP_TASK {taskId}
def task_pick(ctx, req):
    t = _task(ctx)
    tid = int(req.get("taskId") or 0)
    if tid not in t["tasks"]:
        raise GameError(-7, "no task")
    if len(t["picked"]) >= int(ctx.config.value("CHRISTMAS:PICK_UP_COUNT", 1)):
        raise GameError(-15, "pick limit")
    t["picked"].append(tid)
    t["base"][str(tid)] = _clears(ctx)
    ctx.save()
    return {"pickUpTasks": t["picked"], "totalCompleteCount": t["count"]}


@route(48, 9)
def task_give_up(ctx, req):
    t = _task(ctx)
    tid = int(req.get("taskId") or 0)
    if tid in t["picked"]:
        t["picked"].remove(tid)
        t["base"].pop(str(tid), None)
    ctx.save()
    return {"pickUpTasks": t["picked"], "targetValues": _targets(ctx, t), "tasks": t["tasks"]}


def _complete(ctx, t, tid) -> None:
    t["picked"].remove(tid)
    t["done"].append(tid)
    t["count"] += 1


@route(48, 5)  # IMMEDIATELY_COMPLETE_TASK {taskId}
def task_complete_now(ctx, req):
    t = _task(ctx)
    tid = int(req.get("taskId") or 0)
    row = ctx.config.index("TaskSetting").get(tid)
    if row is None or tid not in t["picked"]:
        raise GameError(-16, "not picked")
    led = ctx.ledger()
    led.pay_jade(int(row.get("completeCost") or 0), ctx.config.value("CHRISTMAS:COMPLETE_COST_TYPES"))
    _complete(ctx, t, tid)
    ctx.save()
    return {"completeTasks": t["done"], "costResults": led.costs}


@route(48, 6)  # GET_REWARD {taskId}
def task_reward(ctx, req):
    t = _task(ctx)
    tid = int(req.get("taskId") or 0)
    row = ctx.config.index("TaskSetting").get(tid)
    if row is None:
        raise GameError(-7, "no task")
    if tid in t["picked"] and _targets(ctx, t).get(str(tid), 0) >= int(row["target"]):
        _complete(ctx, t, tid)
    if tid not in t["done"] or tid in t["got"]:
        raise GameError(-9, "not complete")
    led = ctx.ledger()
    led.grant_reward_id(row["rewardId"])
    t["got"].append(tid)
    ctx.save()
    return {"rewardResults": led.rewards, "targetValues": _targets(ctx, t), "tasks": t["tasks"]}


@route(48, 4)  # BUY_TASK
def task_buy(ctx, req):
    t = _task(ctx)
    costs = ctx.config.value("CHRISTMAS:BUY_COMPLETE_TIMES_COSTS", [50])
    led = ctx.ledger()
    led.pay_jade(int(costs[min(t["bought"], len(costs) - 1)]))
    t["bought"] += 1
    ctx.save()
    return {"costResults": led.costs, "todayBuyCompleteCount": t["bought"], "totalCompleteCount": t["count"]}


@route(48, 10)
def task_clear_cool(ctx, req):
    t = _task(ctx)
    t["cool"] = 0
    ctx.save()
    return []


# ------------------------------------------------------------- 75 monopoly
def _mono(ctx, key="monopoly") -> dict:
    return ctx.state.setdefault(key, {"pos": 1, "dice": 0, "special": 0, "task": 0, "records": [],
                                      "day": "", "free": 0})


def _mono_dice(ctx, m, step: int, led) -> dict:
    total = int(ctx.config.value("MONOPOLY:TOTAL_POSITION", 21))
    m["pos"] = (int(m["pos"]) - 1 + step) % total + 1
    points = [r for r in ctx.config.rows("PositionPointSetting")]
    reward = random.choice(ctx.config.rows("MonopolyShow"))
    led.grant(show_spec(reward["showType"], reward["showId"], reward["amount"]))
    ctx.save()
    return ctx.blank(75, 2, **{k: v for k, v in {"position": m["pos"], "step": step,
                                                   "rewardResults": led.rewards, "costResults": led.costs}.items()
                                 if k in (ctx.blank(75, 2) or {})})


def _dice_roll(ctx, key: str) -> int:
    weights = ctx.config.value(key, {"1": 1, "2": 1, "3": 1, "4": 1, "5": 1, "6": 1})
    faces = [int(k) for k in weights]
    return random.choices(faces, weights=[int(v) for v in weights.values()])[0]


@route(75, 1)
def mono_load(ctx, req):
    m = _mono(ctx)
    value = ctx.blank(75, 1)
    for k, v in {"position": m["pos"], "dice": ctx.counter("reward_MONOPOLY_0"),
                 "specialDice": m["special"]}.items():
        if isinstance(value, dict) and k in value:
            value[k] = v
    return value


def _mono_roll(ctx, pay: bool, fixed: int | None = None):
    m = _mono(ctx)
    led = ctx.ledger()
    if pay:
        costs = ctx.config.value("MONOPOLY:STEP_COST_CURRENCY", [50])
        led.pay_jade(int(costs[min(len(m["records"]), len(costs) - 1)]))
    elif fixed is None:
        if ctx.counter("reward_MONOPOLY_0") <= 0:
            raise GameError(-1, "no dice")
        ctx.add_counter("reward_MONOPOLY_0", -1)
    step = fixed if fixed else _dice_roll(ctx, "MONOPOLY:DICE_STEP")
    m["records"].append(step)
    return _mono_dice(ctx, m, step, led)


@route(75, 2)
def mono_dice(ctx, req):
    return _mono_roll(ctx, False)


@route(75, 8)
def mono_cost_dice(ctx, req):
    return _mono_roll(ctx, True)


@route(75, 3)  # ADVANCE_DICE {step}: choose the step with a special die
def mono_adv(ctx, req):
    return _mono_roll(ctx, False, max(1, min(6, int(req.get("step") or 1))))


@route(75, 9)
def mono_cost_adv(ctx, req):
    return _mono_roll(ctx, True, max(1, min(6, int(req.get("step") or 1))))


@route(75, 6)  # BUY_GOODS {id, useCurrency}: MonopolyGoods
def mono_buy(ctx, req):
    row = ctx.config.index("MonopolyGoods").get(int(req.get("id") or 0))
    if row is None:
        raise GameError(-2, "goods")
    led = ctx.ledger()
    if req.get("useCurrency"):
        led.pay_jade(int(row["cost"]) * int(row.get("tokenToCurrency") or 1) // 10)
    elif ctx.counter("reward_MONOPOLY_1") < int(row["cost"]):
        raise GameError(-3, "tokens")
    else:
        ctx.add_counter("reward_MONOPOLY_1", -int(row["cost"]))
    led.grant(show_spec(row["showType"], row["showId"], row["amount"]))
    return ctx.blank(75, 6, **{k: v for k, v in {"costResults": led.costs, "rewardResults": led.rewards}.items()
                               if k in (ctx.blank(75, 6) or {})})


@route(75, 4)
def mono_task_reward(ctx, req):
    return []


@route(75, 5)
def mono_give_up(ctx, req):
    return True


@route(75, 7)
def mono_box(ctx, req):
    led = ctx.ledger()
    led.grant({"type": "CURRENCY", "code": 0, "amount": 10000})  # 推测值
    return led.rewards


@route(75, 10)
def mono_pick(ctx, req):
    return True


@route(75, 11)
def mono_complete(ctx, req):
    return []


# ------------------------------------------------------------ 87 new monopoly
def _nm_vo(ctx, cmd, **fields):
    value = ctx.blank(87, cmd)
    if isinstance(value, dict):
        value.update({k: v for k, v in fields.items() if k in value})
    return value


@route(87, 1)
def nm_load(ctx, req):
    m = _mono(ctx, "newmonopoly")
    return _nm_vo(ctx, 1, position=m["pos"])


def _nm_roll(ctx, cmd: int, pay: bool, special: int | None = None):
    m = _mono(ctx, "newmonopoly")
    led = ctx.ledger()
    if m["day"] != _today():
        m.update(day=_today(), free=0)
    if pay:
        costs = ctx.config.value("NEWMONOPOLY:COST_CAST_DICE_COMSUMES", [50])
        led.pay_jade(int(costs[min(len(m["records"]), len(costs) - 1)]))
    elif special is None:
        if m["free"] >= int(ctx.config.value("NEWMONOPOLY:DAILY_FREE_DICE", 8)):
            raise GameError(-1, "no free dice")
        m["free"] += 1
    step = special or _dice_roll(ctx, "NEWMONOPOLY:CAST_DICE_STEPS")
    limit = int(ctx.config.value("NEWMONOPOLY:POSITION_LIMITS", {"valentine": 30}).get("valentine", 30))
    m["pos"] = (int(m["pos"]) - 1 + step) % limit + 1
    m["records"].append(step)
    reward = random.choice(ctx.config.rows("MonopolyShow"))
    led.grant(show_spec(reward["showType"], reward["showId"], reward["amount"]))
    ctx.save()
    return _nm_vo(ctx, cmd, position=m["pos"], step=step, costResults=led.costs,
                  rewardResults=led.rewards)


@route(87, 2)
def nm_cast(ctx, req):
    return _nm_roll(ctx, 2, False)


@route(87, 3)
def nm_cost_cast(ctx, req):
    return _nm_roll(ctx, 3, True)


@route(87, 4)
def nm_special(ctx, req):
    return _nm_roll(ctx, 4, False, max(1, min(6, int(req.get("_") or 1))))


@route(87, 5)
def nm_cost_special(ctx, req):
    return _nm_roll(ctx, 5, True, max(1, min(6, int(req.get("_") or 1))))


@route(87, 6)  # ACCEPT_TASK
def nm_accept(ctx, req):
    return _nm_vo(ctx, 6)


@route(87, 7)  # GIVE_UP_TASK
def nm_give_up(ctx, req):
    return _nm_vo(ctx, 7)


@route(87, 8)  # COMPLETE_TASK
def nm_complete(ctx, req):
    return _nm_vo(ctx, 8)


@route(87, 9)  # DRAW_TASK_REWARD
def nm_task_reward(ctx, req):
    return _nm_vo(ctx, 9)


@route(87, 10)  # BUG_GOODS {cost, goodsId}: MoGoodsItemSetting
def nm_buy(ctx, req):
    row = ctx.config.index("MoGoodsItemSetting").get(int(req.get("goodsId") or 0))
    if row is None:
        raise GameError(-2, "goods")
    led = ctx.ledger()
    led.pay_jade(int(row["cost"]) // 10 if req.get("cost") else 0)
    led.grant(show_spec(row["showType"], row["showId"], row["amount"]))
    return _nm_vo(ctx, 10, costResults=led.costs, rewardResults=led.rewards)


@route(87, 11)
def nm_route(ctx, req):
    return 0


@route(87, 12)
def nm_substitute(ctx, req):
    return _nm_vo(ctx, 12)


@route(87, 13)
def nm_box(ctx, req):
    led = ctx.ledger()
    led.grant({"type": "CURRENCY", "code": 0, "amount": 10000})  # 推测值
    return _nm_vo(ctx, 13, rewardResults=led.rewards)


# ------------------------------------------------------ 158/159 dev commands
@route(158, 1)  # MsgFight GM combat test (not used by the client UI)
def fight_gm_1(ctx, req):
    return None

@route(158, 2)  # MsgFight GM combat test (not used by the client UI)
def fight_gm_2(ctx, req):
    return None

@route(158, 3)  # MsgFight GM combat test (not used by the client UI)
def fight_gm_3(ctx, req):
    return None

@route(158, 4)  # MsgFight GM combat test (not used by the client UI)
def fight_gm_4(ctx, req):
    return None

@route(158, 5)  # MsgFight GM combat test (not used by the client UI)
def fight_gm_5(ctx, req):
    return None

@route(158, 6)  # MsgFight GM combat test (not used by the client UI)
def fight_gm_6(ctx, req):
    return None


@route(159, 1)  # TEST_REWARD {reward}: GM tool — parses a reward list without granting it
def test_reward(ctx, req):
    specs = parse_json(req.get("reward"), [])
    return [{"amount": int(s.get("amount", 1)), "code": int(s.get("code", 0)), "content": "",
             "type": s.get("type", "CURRENCY")} for s in specs if isinstance(s, dict)]


@route(159, 2)
def test_reward_repeat(ctx, req):
    return {}
