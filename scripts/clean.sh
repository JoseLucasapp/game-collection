#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
rm -rf "$ROOT/build" "$ROOT/dist" "$ROOT/out" "$ROOT/tmp"
find "$ROOT" -type f \( -name '*.sqlite' -o -name '*.sqlite-shm' -o -name '*.sqlite-wal' \) -delete
printf 'Generated application files removed.\n'
