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


if __name__ == "__main__":
    unittest.main()
