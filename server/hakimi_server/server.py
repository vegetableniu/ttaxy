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
from .battle import GameConfig
from .battle import decode_long_id
from .defaults import long_id
from .gift import (
    build_gift_list,
    build_progress_rewards,
    build_valid_activities,
    claim_user_gift,
    grant_hero,
)
from .game import (
    ROUTES, Context, GameError, ensure_cards, ensure_groups, group_vo, hero_vo,
    init_new_player, point_value, refresh_points,
)
from .handlers.player import vip_info
from .handlers.equip import equip_vo
from . import handlers  # noqa: F401  (registers @route handlers)
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
            ctx = Context(self, account, record, record.state)
            init_new_player(ctx)
            refresh_points(ctx)
            self.repository.update_state(account, ctx.state)
            record = self.repository.get(account)
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
            state = record.state
            cards = ensure_cards(record, state, self.game_config)
            groups = ensure_groups(record, state)
            self.repository.update_state(account, state)
            info["heros"]["heros"] = [hero_vo(self.schema, card) for card in cards]
            leader = next(g for g in groups["groups"] if g["groupId"] == groups["curGroupId"])
            info["heros"]["leader"] = group_vo(leader)["leaderId"]
            info["heros"]["extendCount"] = int(state.get("pack_extend", 0))
            info["groupVo"].update(
                curGroupId=int(groups["curGroupId"]),
                groups=[group_vo(g) for g in groups["groups"]],
            )
            info["items"] = [
                {"id": long_id(int(i["id"])), "baseId": int(i["base_id"]),
                 "amount": int(i["amount"]), "type": int(i.get("type", 0)),
                 "owner": long_id(record.player_id), "content": ""}
                for i in state.get("items", [])
            ]
            info["actionPoint"]["points"] = {
                kind: point_value(ctx, kind) for kind in (0, 1, 2)
            }
            info["vip"] = vip_info(ctx)
            info["equipVos"] = [equip_vo(ctx, e) for e in ctx.state.get("equips", [])]
            info["buyEquipSpace"] = int(ctx.state.get("equip_extend", 0))
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
            claimed = claim_user_gift(self.schema, record, identifier, self.game_config)
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
        handler = ROUTES.get((request.mod, request.cmd))
        if handler is None:
            raise ProtocolError(f"unimplemented command {request.mod}:{request.cmd}")
        account = self.sessions.get(request.trailing)
        if account is None:
            raise ProtocolError(f"{request.mod}:{request.cmd} has an invalid session")
        record = self.repository.get(account)
        if record is None:
            raise ProtocolError("account no longer exists")
        ctx = Context(self, account, record, record.state)
        try:
            content = handler(ctx, request_value if isinstance(request_value, dict)
                              else {"_": request_value})
        except GameError as error:
            # Nothing is persisted: the request's state changes are discarded.
            print(f"game error {request.mod}:{request.cmd} -> {error.code} ({error})", flush=True)
            return {"code": error.code, "content": None}
        if ctx.dirty:
            self.repository.update_state(account, ctx.state)
        return {"code": 0, "content": content}

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
