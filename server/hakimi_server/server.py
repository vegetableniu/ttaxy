"""Standalone local TCP server entry point.

Only the verified account handshake is enabled at this stage.  Unknown
commands are logged and receive no fabricated success response.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import secrets
import socket
import threading
import time
import traceback
from typing import Any, Callable

from .protocol import (
    ApplicationPacket,
    ProtocolError,
    RESPONSE_STATUS,
    Schema,
    decode,
    encode,
    pack_application_packet,
    unpack_application_packet,
)
from .transport import FrameBuffer, pack_transport_frame
from .login import build_login_info
from .battle import GameConfig, battle_triggers
from .battle import decode_long_id
from .gift import (
    build_gift_list,
    build_progress_rewards,
    build_valid_activities,
    claim_user_gift,
    grant_hero,
)
from .storage import (
    AccountExistsError,
    AccountRepository,
    InvalidAccountError,
    InvalidRoleError,
    RoleNameExistsError,
)


TEST_SESSION = b"localsession0001"


class LocalServer:
    def __init__(
        self,
        schema: Schema,
        repository: AccountRepository,
        game_config: GameConfig,
        session_factory: Callable[[], bytes] | None = None,
    ):
        self.schema = schema
        self.repository = repository
        self.game_config = game_config
        self.session_factory = session_factory or (
            lambda: secrets.token_urlsafe(24).encode("ascii")
        )
        self.sessions: dict[bytes, str] = {}

    def handle(self, request: ApplicationPacket) -> Any:
        request_value = decode(self.schema, request.content) if request.content else {}
        print(
            f"request {request.mod}:{request.cmd} order={request.order} "
            f"session={request.trailing!r} data={request_value!r}",
            flush=True,
        )
        if (request.mod, request.cmd) == (10, 4):  # CHECK_ACCOUNT
            account = str(request_value.get("account") or "")
            try:
                exists = self.repository.exists(account)
            except (InvalidAccountError, ValueError):
                return {"code": -7, "content": False}
            return {"code": 0, "content": exists}
        if (request.mod, request.cmd) == (10, 1):  # CREATE
            account = str(request_value.get("account") or "")
            role_name = str(request_value.get("name") or "")
            selection = int(request_value.get("select", -1))
            try:
                self.repository.create(account, role_name, selection)
            except AccountExistsError:
                return {"code": -1, "content": 0}
            except RoleNameExistsError:
                return {"code": -3, "content": 0}
            except InvalidAccountError:
                return {"code": -7, "content": 0}
            except InvalidRoleError:
                return {"code": -3, "content": 0}
            return {"code": 0, "content": 0}
        if (request.mod, request.cmd) == (10, 2):  # LOGIN
            account = str(request_value.get("account") or "")
            if not self.repository.exists(account):
                return {"code": -5, "content": ""}
            session = self.session_factory()
            self.sessions[session] = account
            return {"code": 0, "content": session.decode("ascii")}
        if (request.mod, request.cmd) == (10, 7):  # LOGIN_INFO
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("LOGIN_INFO has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("LOGIN_INFO account no longer exists")
            info = build_login_info(
                self.schema,
                account_name=record.account,
                role_name=record.role_name,
                player_id=record.player_id,
                hero_id=record.hero_id,
                starter_hero=record.starter_hero,
                created_ms=record.created_ms,
                state=record.state,
            )
            gifts = build_gift_list(self.schema, record)
            info["validGiftVo"] = gifts
            info["hasReward"] = bool(gifts["users"])
            return {"code": 0, "content": info}
        if (request.mod, request.cmd) == (16, 7):  # DRAW_SP_REGISTER
            return {"code": 0, "content": {"comment": 0, "register": 1}}
        if (request.mod, request.cmd) == (16, 1):  # ALL_GIFTS
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("ALL_GIFTS has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("ALL_GIFTS account no longer exists")
            return {"code": 0, "content": build_gift_list(self.schema, record)}
        if (request.mod, request.cmd) == (16, 4):  # DRAW_USER
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("DRAW_USER has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("DRAW_USER account no longer exists")
            identifier = decode_long_id(request_value.get("giftId") or b"")
            claimed = claim_user_gift(self.schema, record, identifier)
            if claimed is None:
                return {"code": -5, "content": []}
            state, reward = claimed
            self.repository.update_state(account, state)
            return {"code": 0, "content": [reward]}
        if (request.mod, request.cmd) == (16, 5):  # HAS_REWARD
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("HAS_REWARD has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("HAS_REWARD account no longer exists")
            return {
                "code": 0,
                "content": bool(build_gift_list(self.schema, record)["users"]),
            }
        if (request.mod, request.cmd) == (16, 9):  # GET_ACTIVITYS
            if request.trailing not in self.sessions:
                raise ProtocolError("GET_ACTIVITYS has an invalid session")
            return {"code": 0, "content": build_valid_activities(self.schema)}
        if (request.mod, request.cmd) == (16, 11):  # PROGRESS_REWARDS
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("PROGRESS_REWARDS has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("PROGRESS_REWARDS account no longer exists")
            return {
                "code": 0,
                "content": build_progress_rewards(self.schema, record),
            }
        if (request.mod, request.cmd) == (46, 2):  # LOAD_REWARD_INFO
            if request.trailing not in self.sessions:
                raise ProtocolError("LOAD_REWARD_INFO has an invalid session")
            return {
                "code": 0,
                "content": {
                    "baseRewardIds": [],
                    "chargeCount": 0,
                    "monthPlayers": 0,
                    "weekPlayers": 0,
                },
            }
        if (request.mod, request.cmd) == (10, 9):  # LOGIN_COMPLETE
            return {"code": 0, "content": 0}
        if (request.mod, request.cmd) == (47, 2):  # GET_SELEF_MENPAI
            # A fresh role has not joined a sect.  Home performs this as a
            # silent refresh and explicitly suppresses the MENPAI_NOT_JOIN
            # error while preserving the original not-joined state.
            return {"code": -8, "content": None}
        if (request.mod, request.cmd) == (13, 12):  # CURRENT_SCORE
            # The client reads the current formation score from index 2.
            # A newly-created role has no accumulated combat power yet.
            return {"code": 0, "content": [0, 0]}
        if (request.mod, request.cmd) == (22, 9):  # MULTI_ACTION
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("MULTI_ACTION has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("MULTI_ACTION account no longer exists")
            battle_id = str(request_value.get("battleId") or "")
            embattle = request_value.get("embattle") or []
            triggers = battle_triggers(
                self.game_config, record, battle_id, embattle
            )
            battle = self.game_config.battle(battle_id)
            coins = sum(int(trigger["coins"]) for trigger in triggers)
            battle_level = max(1, int(battle.get("level") or 1))
            state = record.state
            state["pending_battle"] = {
                "battle_id": battle_id,
                "cost": int(battle.get("cost") or 0),
                "coins": coins,
                "exp": battle_level * 10,
                "success": True,
            }
            self.repository.update_state(account, state)
            return {"code": 0, "content": triggers}
        if (request.mod, request.cmd) == (22, 5):  # EXIT
            account = self.sessions.get(request.trailing)
            if account is None:
                raise ProtocolError("EXIT has an invalid session")
            record = self.repository.get(account)
            if record is None:
                raise ProtocolError("EXIT account no longer exists")
            state = record.state
            pending = state.pop("pending_battle", None)
            costs = []
            rewards = []
            if pending and pending.get("success"):
                battle_id = pending["battle_id"]
                first_clear = battle_id not in state["battles"]
                if first_clear:
                    state["battles"].append(battle_id)
                state["daily_counts"][battle_id] = (
                    int(state["daily_counts"].get(battle_id, 0)) + 1
                )
                old_points = int(state["action_points"].get("0", 0))
                cost = int(pending.get("cost", 0))
                state["action_points"]["0"] = max(
                    0,
                    old_points - cost,
                )
                coins = int(pending.get("coins", 0))
                exp_gain = int(pending.get("exp", 0))
                state["wallet"]["copper"] = int(state["wallet"].get("copper", 0)) + coins
                player = state["player"]
                player["exp"] = int(player.get("exp", 0)) + exp_gain
                while player["level"] in self.game_config.levels:
                    need = int(self.game_config.levels[player["level"]].get("exp") or 0)
                    if need <= 0 or player["exp"] < need:
                        break
                    player["exp"] -= need
                    player["level"] += 1
                costs.append({
                    "amount": -cost,
                    "code": 0,
                    "contents": {
                        "point": state["action_points"]["0"],
                        "refreshTime": int(time.time() * 1000),
                    },
                    "type": 4,
                })
                rewards.extend([
                    {
                        "additionRate": {},
                        "amount": coins,
                        "code": 0,
                        "contents": {},
                        "mail": False,
                        "type": 1,
                    },
                    {
                        "additionRate": {},
                        "amount": exp_gain,
                        "code": 0,
                        "contents": {
                            "level": player["level"],
                            "exp": player["exp"],
                        },
                        "mail": False,
                        "type": 0,
                    },
                ])
                if battle_id == "CN01BN01" and first_clear:
                    rewards.extend(
                        grant_hero(self.schema, record, state, 71)
                        for _ in range(5)
                    )
                self.repository.update_state(account, state)
            return {
                "code": 0,
                "content": {
                    "costAndReward": {"costs": costs, "rewards": rewards},
                    "failedTimes": 0,
                    "hasDemog": False,
                },
            }
        raise ProtocolError(f"unimplemented command {request.mod}:{request.cmd}")

    def response(self, request: ApplicationPacket, value: Any) -> bytes:
        content = encode(self.schema, self.schema.response_type(request.mod, request.cmd), value)
        packet = ApplicationPacket(
            encoding=0,
            status=RESPONSE_STATUS,
            order=request.order,
            identity=0,
            cmd=request.cmd,
            mod=request.mod,
            content=content,
        )
        return pack_transport_frame(pack_application_packet(packet))


def serve_connection(connection: socket.socket, address: tuple[str, int], server: LocalServer) -> None:
    print(f"connected {address[0]}:{address[1]}", flush=True)
    frames = FrameBuffer()
    with connection:
        while True:
            chunk = connection.recv(65536)
            if not chunk:
                break
            for application in frames.feed(chunk):
                try:
                    request = unpack_application_packet(application)
                    value = server.handle(request)
                    response = server.response(request, value)
                    connection.sendall(response)
                    print(
                        f"response {request.mod}:{request.cmd} order={request.order} "
                        f"bytes={len(response)}",
                        flush=True,
                    )
                except (ProtocolError, KeyError, TypeError, ValueError) as error:
                    print(f"request rejected: {error}", flush=True)
                    traceback.print_exc()
                    return
                except Exception:
                    print("unexpected request failure", flush=True)
                    traceback.print_exc()
                    return
    print(f"disconnected {address[0]}:{address[1]}", flush=True)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", default=9001, type=int)
    parser.add_argument("--data", type=Path)
    args = parser.parse_args()

    project = Path(__file__).resolve().parents[2]
    schema = Schema.load(
        project / "05_改造" / "schema" / "protocol_schema.json",
        project / "05_改造" / "schema" / "protocol_codes.json",
    )
    data_path = args.data or project / "server" / "data" / "hakimi.db"
    game_config = GameConfig(project / "05_改造" / "data" / "config_dump.json")
    local_server = LocalServer(schema, AccountRepository(data_path), game_config)
    with socket.create_server((args.host, args.port)) as listener:
        print(f"Hakimi local server listening on {args.host}:{args.port}", flush=True)
        while True:
            connection, address = listener.accept()
            threading.Thread(
                target=serve_connection,
                args=(connection, address, local_server),
                daemon=True,
            ).start()


if __name__ == "__main__":
    main()
