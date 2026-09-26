"""Small SQLite store for local accounts and role identity."""

from __future__ import annotations

from dataclasses import dataclass
from contextlib import contextmanager
from pathlib import Path
import sqlite3
import time
import unicodedata
import json


SCHEMA_VERSION = 2


class AccountExistsError(ValueError):
    pass


class RoleNameExistsError(ValueError):
    pass


class InvalidAccountError(ValueError):
    pass


class InvalidRoleError(ValueError):
    pass


@dataclass(frozen=True)
class AccountRecord:
    account: str
    player_id: int
    hero_id: int
    role_name: str
    starter_hero: int
    created_ms: int
    updated_ms: int
    state_json: str

    @property
    def state(self) -> dict:
        state = initial_state()
        stored = json.loads(self.state_json or "{}")
        for key, value in stored.items():
            if isinstance(value, dict) and isinstance(state.get(key), dict):
                state[key].update(value)
            else:
                state[key] = value
        return state


def initial_state() -> dict:
    return {
        "player": {"level": 1, "exp": 0},
        "wallet": {
            "copper": 0,
            "gold": 0,
            "gift": 0,
            "stone": 0,
            "inter": 0,
            "friendship": 0,
            "fragment": 0,
            "coupon": 0,
            "exploit": 0,
            "orange": 0,
            "purple": 0,
            "totalCharge": 0,
            "stageCharges": {},
        },
        "action_points": {"0": 100, "1": 10, "2": 0},
        "battles": [],
        "campaigns": [],
        "daily_counts": {},
        "heroes": [],
        "claimed_gifts": [],
    }


def _role_name_width(value: str) -> int:
    return sum(2 if unicodedata.east_asian_width(char) in {"W", "F"} else 1 for char in value)


def validate_account(account: str) -> None:
    if not account or len(account) > 128 or any(char.isspace() for char in account):
        raise InvalidAccountError("invalid account name")


def validate_role_name(role_name: str) -> None:
    if not role_name or any(ord(char) > 0xFFFF for char in role_name):
        raise InvalidRoleError("invalid role name")
    if not 4 <= _role_name_width(role_name) <= 12:
        raise InvalidRoleError("role name length must be between 4 and 12 display cells")
    if any(unicodedata.category(char)[0] in {"C", "P", "Z"} for char in role_name):
        raise InvalidRoleError("role name contains unsupported characters")


class AccountRepository:
    def __init__(self, path: Path | str):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self._migrate()

    @contextmanager
    def _connect(self):
        connection = sqlite3.connect(self.path, timeout=5)
        connection.row_factory = sqlite3.Row
        connection.execute("PRAGMA foreign_keys = ON")
        connection.execute("PRAGMA synchronous = FULL")
        try:
            yield connection
            connection.commit()
        except Exception:
            connection.rollback()
            raise
        finally:
            connection.close()

    def _migrate(self) -> None:
        with self._connect() as connection:
            connection.execute("PRAGMA journal_mode = WAL")
            connection.execute(
                """
                CREATE TABLE IF NOT EXISTS metadata (
                    key TEXT PRIMARY KEY,
                    value TEXT NOT NULL
                )
                """
            )
            connection.execute(
                """
                CREATE TABLE IF NOT EXISTS accounts (
                    account TEXT PRIMARY KEY,
                    player_id INTEGER NOT NULL UNIQUE,
                    hero_id INTEGER NOT NULL UNIQUE,
                    role_name TEXT NOT NULL UNIQUE,
                    starter_hero INTEGER NOT NULL,
                    created_ms INTEGER NOT NULL,
                    updated_ms INTEGER NOT NULL,
                    state_json TEXT NOT NULL DEFAULT '{}'
                )
                """
            )
            columns = {
                row[1] for row in connection.execute("PRAGMA table_info(accounts)")
            }
            if "state_json" not in columns:
                connection.execute(
                    "ALTER TABLE accounts ADD COLUMN state_json TEXT NOT NULL DEFAULT '{}'"
                )
            connection.execute(
                "INSERT OR REPLACE INTO metadata(key, value) VALUES('schema_version', ?)",
                (str(SCHEMA_VERSION),),
            )

    @staticmethod
    def _record(row: sqlite3.Row | None) -> AccountRecord | None:
        if row is None:
            return None
        return AccountRecord(**dict(row))

    def get(self, account: str) -> AccountRecord | None:
        with self._connect() as connection:
            row = connection.execute(
                """
                SELECT account, player_id, hero_id, role_name, starter_hero,
                       created_ms, updated_ms, state_json
                FROM accounts WHERE account = ?
                """,
                (account,),
            ).fetchone()
        return self._record(row)

    def exists(self, account: str) -> bool:
        return self.get(account) is not None

    def create(self, account: str, role_name: str, selection: int) -> AccountRecord:
        validate_account(account)
        validate_role_name(role_name)
        starter_heroes = {0: 1001, 1: 1021}
        if selection not in starter_heroes:
            raise InvalidRoleError("unknown starter hero selection")

        now_ms = int(time.time() * 1000)
        with self._connect() as connection:
            connection.execute("BEGIN IMMEDIATE")
            if connection.execute(
                "SELECT 1 FROM accounts WHERE account = ?", (account,)
            ).fetchone():
                raise AccountExistsError(account)
            if connection.execute(
                "SELECT 1 FROM accounts WHERE role_name = ?", (role_name,)
            ).fetchone():
                raise RoleNameExistsError(role_name)
            player_id = connection.execute(
                "SELECT COALESCE(MAX(player_id), 10000) + 1 FROM accounts"
            ).fetchone()[0]
            hero_id = player_id * 10 + 1
            connection.execute(
                """
                INSERT INTO accounts(
                    account, player_id, hero_id, role_name, starter_hero,
                    created_ms, updated_ms, state_json
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    account,
                    player_id,
                    hero_id,
                    role_name,
                    starter_heroes[selection],
                    now_ms,
                    now_ms,
                    json.dumps(initial_state(), ensure_ascii=False, sort_keys=True),
                ),
            )
        record = self.get(account)
        if record is None:
            raise RuntimeError("created account could not be reloaded")
        return record

    def find_by_role(self, role_name: str) -> AccountRecord | None:
        with self._connect() as connection:
            row = connection.execute(
                """
                SELECT account, player_id, hero_id, role_name, starter_hero,
                       created_ms, updated_ms, state_json
                FROM accounts WHERE role_name = ?
                """,
                (role_name,),
            ).fetchone()
        return self._record(row)

    def all_accounts(self) -> list[AccountRecord]:
        with self._connect() as connection:
            rows = connection.execute(
                """
                SELECT account, player_id, hero_id, role_name, starter_hero,
                       created_ms, updated_ms, state_json
                FROM accounts ORDER BY player_id
                """
            ).fetchall()
        return [self._record(row) for row in rows]

    def rename(self, account: str, role_name: str) -> None:
        validate_role_name(role_name)
        with self._connect() as connection:
            connection.execute("BEGIN IMMEDIATE")
            if connection.execute(
                "SELECT 1 FROM accounts WHERE role_name = ? AND account != ?",
                (role_name, account),
            ).fetchone():
                raise RoleNameExistsError(role_name)
            connection.execute(
                "UPDATE accounts SET role_name = ? WHERE account = ?", (role_name, account)
            )

    def update_state(self, account: str, state: dict) -> AccountRecord:
        now_ms = int(time.time() * 1000)
        payload = json.dumps(state, ensure_ascii=False, sort_keys=True)
        with self._connect() as connection:
            cursor = connection.execute(
                "UPDATE accounts SET state_json = ?, updated_ms = ? WHERE account = ?",
                (payload, now_ms, account),
            )
            if cursor.rowcount != 1:
                raise InvalidAccountError("account not found")
        record = self.get(account)
        if record is None:
            raise InvalidAccountError("account not found")
        return record
