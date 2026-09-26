from pathlib import Path
import sys
import tempfile
import unittest


SERVER_ROOT = Path(__file__).resolve().parents[1]
PROJECT_ROOT = SERVER_ROOT.parent
sys.path.insert(0, str(SERVER_ROOT))

from hakimi_server.protocol import (  # noqa: E402
    ApplicationPacket,
    ProtocolError,
    Schema,
    decode,
    encode,
    unpack_application_packet,
)
from hakimi_server.server import LocalServer, TEST_SESSION  # noqa: E402
from hakimi_server.storage import AccountRepository  # noqa: E402
from hakimi_server.battle import GameConfig  # noqa: E402
from hakimi_server.defaults import long_id  # noqa: E402
from hakimi_server.gift import gift_id  # noqa: E402
from hakimi_server.transport import unpack_transport_frame  # noqa: E402


class StartupSequenceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.schema = Schema.load(
            PROJECT_ROOT / "05_改造" / "schema" / "protocol_schema.json",
            PROJECT_ROOT / "05_改造" / "schema" / "protocol_codes.json",
        )
        cls.game_config = GameConfig(
            PROJECT_ROOT / "05_改造" / "data" / "config_dump.json"
        )
    def setUp(self):
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.repository = AccountRepository(
            Path(self.temporary_directory.name) / "hakimi.db"
        )
        self.repository.create("localuser.1_1", "本地玩家", 0)
        self.server = LocalServer(
            self.schema,
            self.repository,
            self.game_config,
            session_factory=lambda: TEST_SESSION,
        )

    def tearDown(self):
        self.temporary_directory.cleanup()

    def request(self, mod, cmd, value, *, order=0, session=b""):
        return ApplicationPacket(
            encoding=0,
            status=0,
            order=order,
            identity=0,
            cmd=cmd,
            mod=mod,
            content=encode(self.schema, self.schema.request_type(mod, cmd), value),
            trailing=session,
        )

    def round_trip_response(self, request):
        value = self.server.handle(request)
        frame = self.server.response(request, value)
        packet = unpack_application_packet(unpack_transport_frame(frame))
        return decode(self.schema, packet.content)

    def test_verified_main_city_startup_sequence(self):
        requests = [
            self.request(
                10,
                4,
                {
                    "timestamp": 1,
                    "key": "localsign",
                    "account": "localuser.1_1",
                },
                order=0,
            ),
            self.request(
                10,
                2,
                {
                    "account": "localuser.1_1",
                    "adult": False,
                    "appId": "com.eyugame.ahxy.mi",
                    "channel": None,
                    "device": 1,
                    "idfa": "02:00:00:00:00:00",
                    "key": "localsign",
                    "origin": "localuser",
                    "timestamp": 1,
                    "token": "02:00:00:00:00:00",
                },
                order=1,
            ),
            self.request(10, 7, {}, order=2, session=TEST_SESSION),
            self.request(16, 7, {}, order=3, session=TEST_SESSION),
            self.request(10, 9, {}, order=4, session=TEST_SESSION),
            self.request(47, 2, {}, order=5, session=TEST_SESSION),
            self.request(13, 12, {}, order=6, session=TEST_SESSION),
        ]

        responses = [self.round_trip_response(request) for request in requests]

        self.assertTrue(responses[0]["content"])
        self.assertEqual(responses[1]["content"], TEST_SESSION.decode("ascii"))
        self.assertEqual(responses[2]["content"]["asset"], 1000)
        self.assertEqual(responses[2]["content"]["player"]["level"], 1)
        self.assertEqual(responses[3]["content"]["register"], 1)
        self.assertEqual(responses[4]["content"], 0)
        self.assertEqual(responses[5], {"code": -8, "content": None})
        self.assertEqual(responses[6]["content"][0], 0)
        self.assertGreater(responses[6]["content"][1], 0)

    def test_login_info_rejects_wrong_session(self):
        request = self.request(10, 7, {}, session=b"wrong")
        with self.assertRaisesRegex(ProtocolError, "invalid session"):
            self.server.handle(request)

    def test_new_account_create_then_login(self):
        account = "fresh.1_1"
        check = self.round_trip_response(
            self.request(
                10,
                4,
                {"account": account, "key": "localsign", "timestamp": 1},
            )
        )
        self.assertFalse(check["content"])

        create = self.round_trip_response(
            self.request(
                10,
                1,
                {
                    "account": account,
                    "channel": 0,
                    "device": "device",
                    "idfa": "",
                    "invite": "",
                    "key": "localsign",
                    "name": "新建玩家",
                    "origin": "fresh",
                    "purchaseCode": "",
                    "select": 1,
                    "timestamp": 1,
                },
            )
        )
        self.assertEqual(create, {"code": 0, "content": 0})
        self.assertTrue(self.repository.exists(account))

        login = self.round_trip_response(
            self.request(
                10,
                2,
                {
                    "account": account,
                    "adult": False,
                    "appId": "com.eyugame.ahxy.mi",
                    "channel": None,
                    "device": 1,
                    "idfa": "device",
                    "key": "localsign",
                    "origin": "fresh",
                    "timestamp": 1,
                    "token": "device",
                },
            )
        )
        self.assertEqual(login["code"], 0)
        info = self.round_trip_response(
            self.request(10, 7, {}, session=TEST_SESSION)
        )
        self.assertEqual(info["content"]["player"]["name"], "新建玩家")
        self.assertEqual(info["content"]["player"]["baseId"], 1021)

    def test_unknown_command_is_not_fabricated(self):
        request = ApplicationPacket(encoding=0, status=0, order=0, identity=0,
                                    cmd=99, mod=99, content=b"", trailing=b"")
        with self.assertRaisesRegex(ProtocolError, "unimplemented command"):
            self.server.handle(request)

    def test_first_guide_battle_and_exit_are_persisted(self):
        self.round_trip_response(
            self.request(
                10,
                2,
                {
                    "account": "localuser.1_1",
                    "adult": False,
                    "appId": "com.eyugame.ahxy.mi",
                    "channel": None,
                    "device": 1,
                    "idfa": "device",
                    "key": "localsign",
                    "origin": "localuser",
                    "timestamp": 1,
                    "token": "device",
                },
            )
        )
        record = self.repository.get("localuser.1_1")
        battle = self.round_trip_response(
            self.request(
                22,
                9,
                {
                    "battleId": "CN01BN01",
                    "embattle": [
                        [long_id(record.hero_id), long_id(0)],
                        [long_id(0), long_id(0)],
                        [long_id(0), long_id(0)],
                    ],
                    "friend": long_id(-1),
                },
                session=TEST_SESSION,
            )
        )
        self.assertTrue(battle["content"][0]["success"])
        self.assertEqual(battle["content"][0]["coins"], 150)
        self.assertGreater(len(battle["content"][0]["reports"]), 40)

        exit_response = self.round_trip_response(
            self.request(22, 5, {}, session=TEST_SESSION)
        )
        self.assertEqual(exit_response["code"], 0)
        self.assertEqual(exit_response["content"]["costAndReward"]["rewards"][0]["amount"], 150)
        self.assertEqual(exit_response["content"]["costAndReward"]["rewards"][1]["amount"], 60)
        first_rewards = exit_response["content"]["costAndReward"]["rewards"]
        self.assertEqual([item["code"] for item in first_rewards[2:]], [71] * 5)
        self.assertEqual(len({item["contents"]["id"] for item in first_rewards[2:]}), 5)
        state = self.repository.get("localuser.1_1").state
        self.assertIn("CN01BN01", state["battles"])
        self.assertEqual(state["action_points"]["0"], 95)
        self.assertEqual(state["wallet"]["copper"], 150)
        self.assertEqual(state["player"]["exp"], 60)
        self.assertEqual([card["base_id"] for card in state["cards"][1:]], [71] * 5)

    def test_second_battle_returns_all_configured_waves(self):
        self.round_trip_response(
            self.request(10, 2, {
                "account": "localuser.1_1", "adult": False,
                "appId": "com.eyugame.ahxy.mi", "channel": None,
                "device": 1, "idfa": "device", "key": "localsign",
                "origin": "localuser", "timestamp": 1, "token": "device",
            })
        )
        record = self.repository.get("localuser.1_1")
        state = record.state
        state["battles"] = ["CN01BN01"]
        self.repository.update_state("localuser.1_1", state)
        response = self.round_trip_response(
            self.request(22, 9, {
                "battleId": "CN01BN02",
                "embattle": [
                    [long_id(record.hero_id), long_id(0)],
                    [long_id(0), long_id(0)],
                    [long_id(0), long_id(0)],
                ],
                "friend": long_id(-1),
            }, session=TEST_SESSION)
        )
        self.assertEqual(len(response["content"]), 2)
        self.assertFalse(response["content"][0]["finished"])
        self.assertTrue(response["content"][1]["finished"])
        self.assertEqual(sum(item["coins"] for item in response["content"]), 150)

    def test_assistant_slot_fights_with_commended_bot(self):
        self.round_trip_response(
            self.request(10, 2, {
                "account": "localuser.1_1", "adult": False,
                "appId": "com.eyugame.ahxy.mi", "channel": None,
                "device": 1, "idfa": "device", "key": "localsign",
                "origin": "localuser", "timestamp": 1, "token": "device",
            })
        )
        record = self.repository.get("localuser.1_1")
        state = record.state
        state["battles"] = ["CN01BN01"]
        self.repository.update_state("localuser.1_1", state)
        commends = self.round_trip_response(self.request(19, 5, {}, session=TEST_SESSION))
        friend = commends["content"][0]["id"]
        response = self.round_trip_response(
            self.request(22, 2, {
                "battleId": "CN01BN02",
                "embattle": [
                    [long_id(record.hero_id), long_id(-1)],
                    [long_id(0), long_id(0)],
                    [long_id(0), long_id(0)],
                ],
                "friend": friend,
            }, session=TEST_SESSION)
        )
        self.assertEqual(response["code"], 0)
        resume = self.round_trip_response(self.request(22, 3, {}, session=TEST_SESSION))
        self.assertEqual(resume["content"]["assistant"]["name"], commends["content"][0]["name"])

    def test_new_player_gift_is_claimed_once_and_restored_on_login(self):
        self.round_trip_response(
            self.request(10, 2, {
                "account": "localuser.1_1", "adult": False,
                "appId": "com.eyugame.ahxy.mi", "channel": None,
                "device": 1, "idfa": "device", "key": "localsign",
                "origin": "localuser", "timestamp": 1, "token": "device",
            })
        )
        record = self.repository.get("localuser.1_1")
        state = record.state
        state["battles"].append("CN01BN01")
        self.repository.update_state(record.account, state)
        record = self.repository.get(record.account)

        gifts = self.round_trip_response(
            self.request(16, 1, {}, session=TEST_SESSION)
        )
        self.assertEqual(
            [gift["description"]["showId"] for gift in gifts["content"]["users"]],
            ["311", "103"],
        )
        identifier = gift_id(record, 1)
        draw = self.round_trip_response(
            self.request(16, 4, {"giftId": long_id(identifier)}, session=TEST_SESSION)
        )
        self.assertEqual(draw["code"], 0)
        self.assertEqual(draw["content"][0]["type"], 5)
        self.assertEqual(draw["content"][0]["code"], 311)
        self.assertEqual(draw["content"][0]["contents"]["baseId"], 311)

        duplicate = self.round_trip_response(
            self.request(16, 4, {"giftId": long_id(identifier)}, session=TEST_SESSION)
        )
        self.assertEqual(duplicate["code"], -5)
        login = self.round_trip_response(
            self.request(10, 7, {}, session=TEST_SESSION)
        )
        self.assertEqual(len(login["content"]["heros"]["heros"]), 4)
        self.assertEqual(login["content"]["heros"]["heros"][1]["baseId"], 311)
        self.assertEqual(len(login["content"]["validGiftVo"]["users"]), 1)
        self.assertTrue(login["content"]["hasReward"])

    def test_gift_screen_supports_progress_and_retired_activities(self):
        self.round_trip_response(
            self.request(10, 2, {
                "account": "localuser.1_1", "adult": False,
                "appId": "com.eyugame.ahxy.mi", "channel": None,
                "device": 1, "idfa": "device", "key": "localsign",
                "origin": "localuser", "timestamp": 1, "token": "device",
            })
        )
        progress = self.round_trip_response(
            self.request(16, 11, {}, session=TEST_SESSION)
        )
        self.assertEqual(progress["code"], 0)
        self.assertEqual(progress["content"]["level"], 1)
        self.assertEqual(progress["content"]["loginDays"], 1)
        self.assertEqual(progress["content"]["levelTiers"], [])
        activities = self.round_trip_response(
            self.request(16, 9, {}, session=TEST_SESSION)
        )
        self.assertEqual(activities["code"], 0)
        self.assertTrue(activities["content"]["activitys"])  # 单机: all activities open
        self.assertEqual(activities["content"]["logs"], {})
        groupbuy = self.round_trip_response(
            self.request(46, 2, {}, session=TEST_SESSION)
        )
        self.assertEqual(groupbuy["code"], 0)
        self.assertGreater(groupbuy["content"]["chargeCount"], 0)  # 单机: every tier reachable


if __name__ == "__main__":
    unittest.main()
