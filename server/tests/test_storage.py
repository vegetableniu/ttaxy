from pathlib import Path
import sys
import tempfile
import unittest


SERVER_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SERVER_ROOT))

from hakimi_server.storage import (  # noqa: E402
    AccountExistsError,
    AccountRepository,
    InvalidRoleError,
    RoleNameExistsError,
)


class AccountRepositoryTests(unittest.TestCase):
    def setUp(self):
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.path = Path(self.temporary_directory.name) / "hakimi.db"
        self.repository = AccountRepository(self.path)

    def tearDown(self):
        self.temporary_directory.cleanup()

    def test_account_survives_repository_restart(self):
        created = self.repository.create("account.1_1", "本地玩家", 0)
        reopened = AccountRepository(self.path).get("account.1_1")
        self.assertEqual(reopened, created)
        self.assertEqual(reopened.starter_hero, 1001)

    def test_duplicate_account_and_role_name_are_rejected(self):
        self.repository.create("first.1_1", "第一玩家", 0)
        with self.assertRaises(AccountExistsError):
            self.repository.create("first.1_1", "第二玩家", 1)
        with self.assertRaises(RoleNameExistsError):
            self.repository.create("second.1_1", "第一玩家", 1)

    def test_invalid_role_does_not_write_partial_account(self):
        with self.assertRaises(InvalidRoleError):
            self.repository.create("invalid.1_1", "x", 0)
        self.assertFalse(self.repository.exists("invalid.1_1"))


if __name__ == "__main__":
    unittest.main()
