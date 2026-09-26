#!/usr/bin/env python3
"""One-shot raw TCP capture for identifying the native CNetMgr framing.

This is a diagnostic tool.  It deliberately does not send a response.
"""

from __future__ import annotations

import argparse
from datetime import datetime
from pathlib import Path
import socket


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", default=9001, type=int)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--timeout", default=30.0, type=float)
    args = parser.parse_args()

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with socket.create_server((args.host, args.port), reuse_port=False) as server:
        server.settimeout(args.timeout)
        print(f"listening {args.host}:{args.port}", flush=True)
        connection, address = server.accept()
        with connection:
            print(f"accepted {address[0]}:{address[1]}", flush=True)
            connection.settimeout(2.0)
            chunks: list[bytes] = []
            while True:
                try:
                    chunk = connection.recv(65536)
                except TimeoutError:
                    break
                if not chunk:
                    break
                chunks.append(chunk)
                print(f"recv {len(chunk)} bytes: {chunk[:96].hex(' ')}", flush=True)
            payload = b"".join(chunks)
            args.output.write_bytes(payload)
            print(f"saved {len(payload)} bytes at {datetime.now().isoformat()} -> {args.output}", flush=True)


if __name__ == "__main__":
    main()
