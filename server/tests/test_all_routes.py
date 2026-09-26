"""Smoke test: every registered command answers a default request and its
response encodes with the real schema (strict field checking)."""

import contextlib
import io
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from test_domains import DomainTestCase  # noqa: E402
from hakimi_server.defaults import default_value  # noqa: E402
from hakimi_server.game import ROUTES  # noqa: E402


class AllRoutesTest(DomainTestCase):
    def test_every_route_encodes(self):
        self.edit(lambda s: (s["player"].update(level=70),
                             s["wallet"].update(gold=100000, copper=10**8, friendship=10**5)))
        failures = []
        for mod, cmd in sorted(ROUTES):
            req_t = self.schema.request_type(mod, cmd)
            req = ([default_value(self.schema, x) for x in req_t] if isinstance(req_t, list)
                   else default_value(self.schema, req_t) or {})
            try:
                with contextlib.redirect_stdout(io.StringIO()):
                    self.call(mod, cmd, req)
            except Exception as error:  # noqa: BLE001
                if "truncated" in str(error) and self.schema.response_type(mod, cmd) == {}:
                    continue  # command without response content
                failures.append(f"{mod}:{cmd} {type(error).__name__}: {error}")
        self.assertEqual(failures, [])


if __name__ == "__main__":
    unittest.main()
