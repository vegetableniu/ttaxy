"""Business-domain regression tests: every response is encoded with the real
schema, so a wrong field shape fails here instead of on the device."""

from pathlib import Path
import sys
import tempfile
import unittest

SERVER_ROOT = Path(__file__).resolve().parents[1]
PROJECT_ROOT = SERVER_ROOT.parent
sys.path.insert(0, str(SERVER_ROOT))

from hakimi_server.battle import GameConfig  # noqa: E402
from hakimi_server.defaults import long_id  # noqa: E402
from hakimi_server.protocol import (  # noqa: E402
    ApplicationPacket, Schema, decode, encode, unpack_application_packet,
)
from hakimi_server.server import LocalServer, TEST_SESSION  # noqa: E402
from hakimi_server.storage import AccountRepository  # noqa: E402
from hakimi_server.transport import unpack_transport_frame  # noqa: E402

ACCOUNT = "localuser.1_1"


class DomainTestCase(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.schema = Schema.load(
            PROJECT_ROOT / "05_改造" / "schema" / "protocol_schema.json",
            PROJECT_ROOT / "05_改造" / "schema" / "protocol_codes.json",
        )
        cls.config = GameConfig(PROJECT_ROOT / "05_改造" / "data" / "config_dump.json")

    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.repo = AccountRepository(Path(self.tmp.name) / "hakimi.db")
        self.repo.create(ACCOUNT, "本地玩家", 0)
        self.server = LocalServer(self.schema, self.repo, self.config,
                                  session_factory=lambda: TEST_SESSION)
        self.call(10, 2, {"account": ACCOUNT, "adult": False, "appId": "", "channel": None,
                          "device": 1, "idfa": "", "key": "", "origin": "", "timestamp": 1,
                          "token": ""}, session=b"")
        self.call(10, 7, {})

    def tearDown(self):
        self.tmp.cleanup()

    def call(self, mod, cmd, value, session=TEST_SESSION):
        request = ApplicationPacket(
            encoding=0, status=0, order=0, identity=0, cmd=cmd, mod=mod,
            content=encode(self.schema, self.schema.request_type(mod, cmd), value),
            trailing=session)
        frame = self.server.response(request, self.server.handle(request))
        return decode(self.schema, unpack_application_packet(unpack_transport_frame(frame)).content)

    def state(self):
        return self.repo.get(ACCOUNT).state

    def edit(self, change):
        state = self.state()
        change(state)
        self.repo.update_state(ACCOUNT, state)

    def give_card(self, base_id, level=1):
        def change(state):
            uid = state["next_uid"] + 1
            state["next_uid"] = uid
            state["cards"].append({"id": uid, "base_id": base_id, "level": level, "exp": 0,
                                   "locked": False, "power_skill": 0, "skill_exp": 0})
        self.edit(change)
        return self.state()["next_uid"]


class HeroTests(DomainTestCase):
    def leader(self):
        return self.state()["cards"][0]

    def test_swallow_levels_up_and_charges_copper(self):
        self.edit(lambda s: s["wallet"].update(copper=100000))
        food = [self.give_card(310), self.give_card(310)]  # 蟠桃 2000 exp each
        leader = self.leader()
        result = self.call(13, 4, {"src": long_id(leader["id"]), "tar": [long_id(f) for f in food]})
        self.assertEqual(result["code"], 0)
        hero = result["content"]["hero"]
        self.assertGreater(hero["level"], 1)
        state = self.state()
        self.assertEqual(len(state["cards"]), 3)  # 3 starter cards, food consumed
        # coinRate of 至尊宝 is 1.0: cost equals total fed exp
        self.assertEqual(state["wallet"]["copper"], 100000 - 4000)

    def test_failed_request_changes_nothing(self):
        self.edit(lambda s: s["wallet"].update(copper=0))
        food = self.give_card(310)
        before = self.state()
        result = self.call(13, 4, {"src": long_id(self.leader()["id"]), "tar": [long_id(food)]})
        self.assertEqual(result["code"], -100)  # no copper
        self.assertEqual(self.state()["cards"], before["cards"])

    def test_rank_up_keeps_level_and_consumes_materials(self):
        self.edit(lambda s: (s["wallet"].update(copper=5000),
                             s["cards"][0].update(level=15)))
        peach = self.give_card(103)  # 人参果
        result = self.call(13, 5, {"src": long_id(self.leader()["id"]), "tar": [long_id(peach)]})
        self.assertEqual(result["code"], 0)
        self.assertEqual(result["content"]["hero"]["baseId"], 1002)
        self.assertEqual(result["content"]["hero"]["level"], 15)
        self.assertEqual(self.state()["wallet"]["copper"], 4000)

    def test_starting_state_and_protected_cards(self):
        state = self.state()
        self.assertEqual(sorted(c["base_id"] for c in state["cards"]), [1001, 1021, 1041])
        self.assertEqual(state["wallet"]["copper"], 100000)
        self.assertEqual(state["wallet"]["gift"], 300)
        # leader is protected (locked); the fielded 1041 is merely in use
        result = self.call(13, 7, {"tar": [long_id(self.leader()["id"])]})
        self.assertEqual(result["code"], -15)
        fielded = next(c for c in state["cards"] if c["base_id"] == 1041)
        result = self.call(13, 7, {"tar": [long_id(fielded["id"])]})
        self.assertEqual(result["code"], -13)

    def test_sell_and_formation(self):
        spare = self.give_card(71, level=3)
        other = self.give_card(71)
        result = self.call(13, 2, {"groupId": 1, "heros": [long_id(self.leader()["id"]), long_id(other)]})
        self.assertEqual(result["code"], 0)
        result = self.call(13, 7, {"tar": [long_id(spare)]})
        self.assertEqual(result["code"], 0)
        info = self.config.heroes[71]
        self.assertEqual(result["content"]["rewards"][0]["amount"],
                         int(info["baseCoins"] + 3 * info["growCoins"]))
        groups = self.call(13, 13, {})["content"]["groups"]
        self.assertEqual(len(groups), 3)


class ItemTests(DomainTestCase):
    def test_compose_and_sell_items(self):
        def change(state):
            state["wallet"]["copper"] = 10000
            state["items"] = [{"id": 900001, "base_id": 311, "type": 2, "amount": 5}]
        self.edit(change)
        result = self.call(12, 2, {"extend": False, "itemId": long_id(900001)})
        self.assertEqual(result["code"], 0)
        self.assertTrue(result["content"]["rewards"])
        self.assertEqual(self.state()["items"][0]["amount"], 3)
        result = self.call(12, 3, {"amount": 3, "itemId": long_id(900001)})
        self.assertEqual(result["code"], 0)
        self.assertEqual(self.state()["items"], [])
        items = self.call(12, 1, {})
        self.assertEqual(items["code"], 0)


class PlayerTests(DomainTestCase):
    def test_player_routes_encode(self):
        self.assertEqual(self.call(11, 2, {})["content"]["gift"], 300)
        self.assertFalse(self.call(11, 3, {})["content"]["vip"])
        info = self.call(11, 12, {})["content"]
        self.assertTrue(info["first"])
        checked = self.call(11, 13, {})
        self.assertEqual(checked["code"], 0)
        self.assertEqual(self.call(11, 13, {})["code"], -13)  # once per day
        points = self.call(21, 2, {})["content"]["points"]
        self.assertEqual(points[0]["point"], 100)
        bought = self.call(21, 1, {})
        self.assertEqual(bought["code"], 0)
        self.assertEqual(self.state()["action_points"]["0"], 200)
        self.assertEqual(self.call(11, 9, {})["code"], -10)  # roulette unlocks at level 5


class LotteryEquipTests(DomainTestCase):
    def test_mall_list_and_draws(self):
        rows = self.call(11, 11, {})["content"]
        self.assertIn("LOTTERY_L1", [r["lotteryType"] for r in rows])
        self.edit(lambda s: (s["wallet"].update(gold=5000, friendship=1000),
                             s["player"].update(level=10)))
        result = self.call(11, 1, {"id": 2, "time": 10})
        self.assertEqual(result["code"], 0)
        stars = [self.config.heroes[r["code"]]["star"] for r in result["content"]["rewards"]]
        self.assertEqual(len(stars), 10)
        self.assertIn(7, stars)  # ten-draw guarantee
        self.assertEqual(self.state()["wallet"]["gold"], 5000 - 2800)
        self.assertEqual(self.call(11, 1, {"id": 1, "time": 1})["code"], 0)

    def test_equipment_flow(self):
        self.edit(lambda s: (s.update(equip_fragments={"11101": 20}),
                             s["wallet"].update(copper=10000)))
        composed = self.call(56, 3, {"baseId": 11101})
        self.assertEqual(composed["code"], 0)
        pack = self.call(56, 6, {})["content"]
        self.assertEqual(pack["usedSpace"], 1)
        equip_id = composed["content"]["id"]
        hero = next(c for c in self.state()["cards"] if c["base_id"] == 1041)  # 二当家
        worn = self.call(56, 2, {"hero": long_id(hero["id"]), "id": equip_id, "position": 1})
        self.assertIn(worn["code"], (0, -4))  # depends on unit type
        self.assertEqual(self.call(56, 7, {"equipId": equip_id, "hero": long_id(hero["id"]),
                                           "position": 1})["code"], 0)


def parse_report(data: bytes) -> dict:
    """Mirror of Module/BattleShow/ReportParser (asserts full consumption)."""
    import struct
    pos = 0
    stop = len(data) - 1  # last byte = result, never consumed

    def take(fmt):
        nonlocal pos
        size = struct.calcsize(fmt)
        assert pos + size <= stop, "read past end"
        value = struct.unpack_from(fmt, data, pos)[0]
        pos += size
        return value

    def delimiter():
        nonlocal pos
        if pos < stop and struct.unpack_from(">b", data, pos)[0] == -1:
            pos += 1
            return True
        return False

    def value():
        return [(take(">b"), take(">i")) for _ in range(take(">b"))]

    def buffs():
        return [(take(">h"), take(">b"), value()) for _ in range(take(">b"))]

    def passives():
        return [(take(">h"), value()) for _ in range(take(">b"))]

    def target():
        return {"id": take(">b"), "state": take(">b"), "value": value(),
                "buffs": buffs(), "passives": passives()}

    def team():
        units = []
        while not delimiter():
            units.append({"slot": take(">b"), "model": take(">H"), "role": take(">b"),
                          "class": take(">b"), "hp": take(">i"), "max": take(">i"),
                          "skill": take(">B")})
        combs = [take(">h") for _ in range(take(">b"))]
        return units

    def info():
        items = []
        while not delimiter():
            items.append((take(">b"), value(), buffs(), passives()))
        return items

    attackers, defenders, rounds = team(), team(), []
    while pos < stop:
        starts = info()
        actions = []
        while not delimiter():
            action = {"id": take(">b"), "skill": take(">h")}
            action["targets"] = [target() for _ in range(take(">b"))]
            if take(">b") != 0:
                target()
            actions.append(action)
        ends = info()
        for _ in range(take(">h")):
            take(">b")
            for _ in range(take(">b")):
                take(">h"), take(">b")
        delimiter()
        rounds.append(actions)
    assert pos == stop
    return {"attackers": attackers, "defenders": defenders, "rounds": rounds,
            "result": data[-1]}


class BattleTests(DomainTestCase):
    def formation(self):
        group = self.state()["groups"]["groups"][0]
        return [[long_id(v) for v in row] for row in group["embattles"]]

    def test_reports_parse_like_the_client_and_hp_is_consistent(self):
        result = self.call(22, 9, {"battleId": "CN01BN01", "embattle": self.formation(),
                                   "friend": long_id(-1)})
        self.assertEqual(result["code"], 0)
        report = parse_report(result["content"][0]["reports"])
        self.assertEqual(len(report["attackers"]), 3)
        self.assertEqual(report["result"], 1)
        hp = {u["slot"]: u["hp"] for u in report["attackers"] + report["defenders"]}
        for actions in report["rounds"]:
            for action in actions:
                for t in action["targets"]:
                    hp[t["id"]] += sum(v for kind, v in t["value"] if kind == 1)
        self.assertTrue(all(hp[u["slot"]] <= 0 for u in report["defenders"]))
        self.assertEqual(self.call(22, 5, {})["code"], 0)
        self.assertIn("CN01BN01", self.state()["battles"])

    def test_progress_lock_sweep_and_failure(self):
        self.assertEqual(self.call(22, 9, {"battleId": "CN01BN02", "embattle": self.formation(),
                                           "friend": long_id(-1)})["code"], -10)
        self.edit(lambda s: s.update(battles=["CN01BN01"]))
        swept = self.call(22, 10, {"battleId": "CN01BN01", "friend": long_id(-1), "requestId": ""})
        self.assertEqual(swept["code"], 0)
        self.assertTrue(swept["content"]["finished"])
        # a hopeless fight (level-1 team vs a level-38 boss chapter) is lost and pays nothing
        self.edit(lambda s: (s.update(battles=[b["id"] for b in self.config.rows("BattleInfoConfig")
                                               if b["id"] < "CN12BN06"]),
                             s["player"].update(level=40)))
        copper = self.state()["wallet"]["copper"]
        lost = self.call(22, 9, {"battleId": "CN12BN06", "embattle": self.formation(),
                                 "friend": long_id(-1)})
        self.assertFalse(lost["content"][-1]["success"])
        exit_vo = self.call(22, 5, {})["content"]
        self.assertEqual(exit_vo["failedTimes"], 1)
        self.assertEqual(self.state()["wallet"]["copper"], copper)
        self.assertEqual(self.call(22, 1, {})["code"], 0)


class EliteMailTests(DomainTestCase):
    def test_elite_attack_buy_and_sweep(self):
        def change(state):
            state["player"]["level"] = 60
            state["wallet"]["gold"] = 1000
            state["wallet"]["totalCharge"] = 100000  # buying elite entries is a recharge perk
            for card in state["cards"]:
                card["level"] = 60
        self.edit(change)
        grid = [[long_id(v) for v in row] for row in self.state()["groups"]["groups"][0]["embattles"]]
        result = self.call(61, 2, {"battleId": "CH01BN01", "embattle": [grid], "quick": False})
        self.assertEqual(result["code"], 0)
        for trigger in result["content"]["triggers"]:
            parse_report(trigger["reports"][0])
        self.assertEqual(self.call(61, 1, {})["code"], 0)
        self.assertEqual(self.call(61, 8, {})["code"], 0)
        self.assertEqual(self.call(61, 6, {"battleId": "CH01BN01"})["code"], 0)

    def test_system_mail_attachment(self):
        import hakimi_server.handlers.email as email
        from hakimi_server.game import Context
        record = self.repo.get(ACCOUNT)
        ctx = Context(self.server, ACCOUNT, record, record.state)
        email.send_system_mail(ctx, 1, [{"type": "CURRENCY", "code": 1, "amount": 88}])
        self.repo.update_state(ACCOUNT, ctx.state)
        box = self.call(17, 1, {})["content"]
        mail_id = box["receives"][0]["id"]
        self.assertTrue(self.call(17, 8, {})["content"])
        drawn = self.call(17, 4, {"mailId": mail_id, "target": {"id": "", "type": 0}})
        self.assertEqual(drawn["code"], 0)
        self.assertEqual(self.state()["wallet"]["gold"], 88)
        self.assertEqual(self.call(17, 4, {"mailId": mail_id, "target": {"id": "", "type": 0}})["code"], -12)


class ChargeTests(DomainTestCase):
    def test_free_recharge_month_card_and_deposit(self):
        order = self.call(11, 4, {"amount": 1, "channel": "", "goods": "1001", "imei": "",
                                  "mac": "", "version": ""})
        self.assertEqual(order["code"], 0)
        self.assertEqual(order["content"]["addition"], "1001*1")
        state = self.state()
        self.assertEqual(state["wallet"]["gold"], 300)
        self.assertEqual(state["wallet"]["totalCharge"], 300)
        self.assertTrue(self.call(11, 3, {})["content"]["vip"])
        self.call(10, 7, {})  # login mails today's month-card return
        box = self.call(17, 1, {})["content"]["receives"]
        self.assertTrue(any(m["title"].startswith("月卡") for m in box))
        self.call(11, 4, {"amount": 1, "channel": "", "goods": "1006", "imei": "", "mac": "", "version": ""})
        self.assertEqual(self.call(31, 1, {})["code"], 0)
        self.assertEqual(self.call(31, 2, {"id": 1})["code"], 0)
        self.assertEqual(self.call(31, 3, {})["code"], -8)  # min days
        self.assertEqual(self.call(90, 1, {})["code"], 0)
        self.assertEqual(self.call(46, 2, {})["code"], 0)


if __name__ == "__main__":
    unittest.main()
