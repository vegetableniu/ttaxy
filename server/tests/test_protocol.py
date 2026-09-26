from pathlib import Path
import sys
import unittest


SERVER_ROOT = Path(__file__).resolve().parents[1]
PROJECT_ROOT = SERVER_ROOT.parent
sys.path.insert(0, str(SERVER_ROOT))

from hakimi_server.protocol import (  # noqa: E402
    ApplicationPacket,
    RESPONSE_STATUS,
    Schema,
    decode,
    encode,
    pack_application_packet,
    unpack_application_packet,
)
from hakimi_server.transport import (  # noqa: E402
    FrameBuffer,
    bp_hash,
    pack_transport_frame,
    unpack_transport_frame,
)
from hakimi_server.login import LOGIN_INFO, build_login_info  # noqa: E402


class ProtocolTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.schema = Schema.load(
            PROJECT_ROOT / "05_改造" / "schema" / "protocol_schema.json",
            PROJECT_ROOT / "05_改造" / "schema" / "protocol_codes.json",
        )

    def test_account_login_request_round_trip(self):
        type_info = self.schema.request_type(10, 2)
        value = {
            "account": "local",
            "adult": True,
            "appId": "",
            "channel": 0,
            "device": 1,
            "idfa": "",
            "key": "",
            "origin": "",
            "timestamp": 123,
            "token": "",
        }
        self.assertEqual(decode(self.schema, encode(self.schema, type_info, value)), value)

    def test_named_object_and_repeated_string_round_trip(self):
        type_name = "com.eyu.mt.module.account.model.AccountVo"
        value = {
            "createdOn": 1_700_000_000_000,
            "dayByContinuous": 1,
            "dayByTotal": 1,
            "id": bytes((0x12, 0x00)),
            "loginOn": 1_700_000_000_000,
            "logoutOn": 1_700_000_000_000,
            "name": "local",
            "online": True,
            "post": 0,
            "state": 0,
            "timeByDay": 0,
            "timeByTotal": 0,
        }
        result = decode(self.schema, encode(self.schema, type_name, value))
        self.assertEqual(result.pop("__type__"), type_name)
        self.assertEqual(result, value)

    def test_application_packet_round_trip(self):
        packet = ApplicationPacket(
            encoding=0,
            status=RESPONSE_STATUS,
            order=7,
            identity=0,
            cmd=4,
            mod=10,
            content=b"payload",
            trailing=b"attachment",
        )
        self.assertEqual(unpack_application_packet(pack_application_packet(packet)), packet)

    def test_native_transport_matches_captured_client_frame(self):
        captured = bytes.fromhex(
            "ff ff ff ff 00 00 00 61 00 00 00 1e 00 00 00 00 00 00 00 00 "
            "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 0a 00 00 "
            "00 3f c0 03 e0 09 74 69 6d 65 73 74 61 6d 70 11 84 6a b6 3f "
            "9f e0 03 6b 65 79 e0 09 6c 6f 63 61 6c 73 69 67 6e e0 07 61 "
            "63 63 6f 75 6e 74 e0 0d 6c 6f 63 61 6c 75 73 65 72 2e 31 5f "
            "31 25 cc 6f b1"
        )
        application = unpack_transport_frame(captured)
        self.assertEqual(bp_hash(application), 0x25CC6FB1)
        self.assertEqual(pack_transport_frame(application), captured)

    def test_native_hash_sign_extends_binary_bytes(self):
        # The ARM client uses `ldrsb` in _Z6BPHashRKSs.
        self.assertEqual(bp_hash(b"\x80"), 0xFFFFFF80)
        self.assertEqual(bp_hash(b"\xff\x01"), 0xFFFFFF81)

    def test_fragmented_transport_stream(self):
        first = pack_transport_frame(b"first")
        second = pack_transport_frame(b"second")
        buffer = FrameBuffer()
        self.assertEqual(buffer.feed(first[:5]), [])
        self.assertEqual(buffer.feed(first[5:] + second[:3]), [b"first"])
        self.assertEqual(buffer.feed(second[3:]), [b"second"])

    def test_login_info_is_fully_encodable(self):
        login = build_login_info(
            self.schema,
            account_name="localuser.1_1",
            role_name="本地玩家",
        )
        result = decode(self.schema, encode(self.schema, LOGIN_INFO, login))
        self.assertEqual(result["player"]["level"], 1)
        self.assertEqual(result["player"]["exp"], 0)
        self.assertEqual(result["wallet"]["gold"], 0)
        self.assertEqual(len(result["heros"]["heros"]), 1)

    def test_historical_sp_record_alias_is_encodable(self):
        value = {"code": 0, "content": {"comment": 0, "register": 1}}
        payload = encode(self.schema, self.schema.response_type(16, 7), value)
        result = decode(self.schema, payload)
        self.assertEqual(result["code"], 0)
        self.assertEqual(result["content"]["comment"], 0)
        self.assertEqual(result["content"]["register"], 1)

    def test_untyped_reward_contents_round_trip(self):
        value = {
            "costs": [{
                "amount": -5,
                "code": 0,
                "contents": {"point": 95, "refreshTime": 1_700_000_000_000},
                "type": 4,
            }],
            "rewards": [{
                "additionRate": {},
                "amount": 10,
                "code": 0,
                "contents": {"level": 1, "exp": 10},
                "mail": False,
                "type": 0,
            }],
        }
        type_name = "com.eyu.mt.module.cost.model.CostAndReward"
        result = decode(self.schema, encode(self.schema, type_name, value))
        self.assertEqual(result["costs"][0]["contents"]["point"], 95)
        self.assertEqual(result["costs"][0]["contents"]["refreshTime"], 1_700_000_000_000)
        self.assertEqual(result["rewards"][0]["contents"], {"level": 1, "exp": 10})


if __name__ == "__main__":
    unittest.main()
