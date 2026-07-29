#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
exec "${ZUMBRA_BIN:-zumbra}" app package --manifest zumbra.toml --target windows --arch amd64 --format all
