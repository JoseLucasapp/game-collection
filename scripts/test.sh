#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
ZUMBRA_BIN="${ZUMBRA_BIN:-zumbra}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

"$ZUMBRA_BIN" check src/main.zum
"$ZUMBRA_BIN" check tests/storage_test.zum
"$ZUMBRA_BIN" check tests/ui_event_test.zum
"$ZUMBRA_BIN" check tests/layout_test.zum

STORAGE_OUTPUT="$("$ZUMBRA_BIN" run tests/storage_test.zum)"
STORAGE_EXPECTED=$'3\nChrono Trigger\nFinal Fantasy IX\nHalo 3\nHalo 3\nPC\nChrono\nHalo 3\n1\nFinal Fantasy IX\nHalo 3\nSteam\n2\ntrue'
if [[ "$STORAGE_OUTPUT" != "$STORAGE_EXPECTED" ]]; then
  printf 'Unexpected storage test output:\n%s\n' "$STORAGE_OUTPUT" >&2
  exit 1
fi

UI_OUTPUT="$("$ZUMBRA_BIN" run tests/ui_event_test.zum)"
UI_EXPECTED=$'edit-game-7\nbutton'
if [[ "$UI_OUTPUT" != "$UI_EXPECTED" ]]; then
  printf 'Unexpected UI event test output:\n%s\n' "$UI_OUTPUT" >&2
  exit 1
fi

LAYOUT_OUTPUT="$("$ZUMBRA_BIN" run tests/layout_test.zum)"
LAYOUT_EXPECTED=$'72\n12\n36\n16'
if [[ "$LAYOUT_OUTPUT" != "$LAYOUT_EXPECTED" ]]; then
  printf 'Unexpected layout test output:\n%s\n' "$LAYOUT_OUTPUT" >&2
  exit 1
fi

mkdir -p "$TMP/vm-data"
VM_OUTPUT="$(XDG_DATA_HOME="$TMP/vm-data" ZUMBRA_DESKTOP_HEADLESS=1 "$ZUMBRA_BIN" app run --manifest zumbra.toml)"
VM_EXPECTED=$'collection-ready\n0'
if [[ "$VM_OUTPUT" != "$VM_EXPECTED" ]]; then
  printf 'Unexpected application VM output:\n%s\n' "$VM_OUTPUT" >&2
  exit 1
fi

mkdir -p "$TMP/native-data"
"$ZUMBRA_BIN" app build --manifest zumbra.toml --target linux --arch amd64 -o "$TMP/zumbra-game-collection"
NATIVE_OUTPUT="$(XDG_DATA_HOME="$TMP/native-data" ZUMBRA_DESKTOP_HEADLESS=1 "$TMP/zumbra-game-collection")"
if [[ "$NATIVE_OUTPUT" != "$VM_EXPECTED" ]]; then
  printf 'Unexpected native application output:\n%s\n' "$NATIVE_OUTPUT" >&2
  exit 1
fi

printf 'Z16 game collection tests passed.\n'
