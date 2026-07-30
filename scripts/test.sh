#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
ZUMBRA_BIN="${ZUMBRA_BIN:-zumbra}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

for source in \
  src/main.zum \
  tests/storage_test.zum \
  tests/exchange_test.zum \
  tests/preferences_test.zum \
  tests/modal_accessibility_test.zum \
  tests/dialog_layout_test.zum \
  tests/navigation_charts_test.zum \
  tests/final_polish_test.zum \
  tests/sidebar_line_chart_test.zum \
  tests/stress_test.zum \
  tests/ui_event_test.zum \
  tests/layout_test.zum; do
  "$ZUMBRA_BIN" check "$source"
done

STORAGE_OUTPUT="$("$ZUMBRA_BIN" run tests/storage_test.zum)"
STORAGE_EXPECTED=$'3\nChrono Trigger\nFinal Fantasy IX\nHalo 3\nHalo 3\nPC\nChrono\nHalo 3\n1\nChrono Trigger\n1\n2\nSteam\nJapão\n3\n2\n1\n1\ntrue\n2\ntrue\n3\nok\n3\n2\ntrue'
if [[ "$STORAGE_OUTPUT" != "$STORAGE_EXPECTED" ]]; then
  printf 'Unexpected storage test output:\n%s\n' "$STORAGE_OUTPUT" >&2
  exit 1
fi

EXCHANGE_OUTPUT="$("$ZUMBRA_BIN" run tests/exchange_test.zum)"
EXCHANGE_EXPECTED=$'true\ntrue\ntrue\n2\n0\n0\n0\n2\ntrue\n2\nNTSC-U\n2\ntrue\ntrue\ntrue'
if [[ "$EXCHANGE_OUTPUT" != "$EXCHANGE_EXPECTED" ]]; then
  printf 'Unexpected exchange test output:\n%s\n' "$EXCHANGE_OUTPUT" >&2
  exit 1
fi

PREFERENCES_OUTPUT="$("$ZUMBRA_BIN" run tests/preferences_test.zum)"
PREFERENCES_EXPECTED=$'true\ntrue\nMais recentes\nPlayStation\nFinal Fantasy'
if [[ "$PREFERENCES_OUTPUT" != "$PREFERENCES_EXPECTED" ]]; then
  printf 'Unexpected preferences test output:\n%s\n' "$PREFERENCES_OUTPUT" >&2
  exit 1
fi

MODAL_OUTPUT="$("$ZUMBRA_BIN" run tests/modal_accessibility_test.zum)"
MODAL_EXPECTED=$'2\n2\nmodal-confirm\n0'
if [[ "$MODAL_OUTPUT" != "$MODAL_EXPECTED" ]]; then
  printf 'Unexpected modal/accessibility test output:\n%s\n' "$MODAL_OUTPUT" >&2
  exit 1
fi

DIALOG_OUTPUT="$("$ZUMBRA_BIN" run tests/dialog_layout_test.zum)"
DIALOG_EXPECTED=$'290\n140\n620\n520\nhidden\n6\ncontain'
if [[ "$DIALOG_OUTPUT" != "$DIALOG_EXPECTED" ]]; then
  printf 'Unexpected dialog layout test output:\n%s\n' "$DIALOG_OUTPUT" >&2
  exit 1
fi


NAVIGATION_OUTPUT="$("$ZUMBRA_BIN" run tests/navigation_charts_test.zum)"
NAVIGATION_EXPECTED=$'280
true
2
2
56'
if [[ "$NAVIGATION_OUTPUT" != "$NAVIGATION_EXPECTED" ]]; then
  printf 'Unexpected navigation/charts test output:
%s
' "$NAVIGATION_OUTPUT" >&2
  exit 1
fi

FINAL_POLISH_OUTPUT="$("$ZUMBRA_BIN" run tests/final_polish_test.zum)"
FINAL_POLISH_EXPECTED=$'368
632
true
3
pieChart
true
0
1000
false'
if [[ "$FINAL_POLISH_OUTPUT" != "$FINAL_POLISH_EXPECTED" ]]; then
  printf 'Unexpected final polish test output:
%s
' "$FINAL_POLISH_OUTPUT" >&2
  exit 1
fi

SIDEBAR_LINE_OUTPUT="$("$ZUMBRA_BIN" run tests/sidebar_line_chart_test.zum)"
SIDEBAR_LINE_EXPECTED=$'600
true
40
lineChart
PlayStation 1'
if [[ "$SIDEBAR_LINE_OUTPUT" != "$SIDEBAR_LINE_EXPECTED" ]]; then
  printf 'Unexpected sidebar/line chart test output:
%s
' "$SIDEBAR_LINE_OUTPUT" >&2
  exit 1
fi

STRESS_OUTPUT="$("$ZUMBRA_BIN" run tests/stress_test.zum)"
STRESS_EXPECTED=$'500\n500\n500\ntrue'
if [[ "$STRESS_OUTPUT" != "$STRESS_EXPECTED" ]]; then
  printf 'Unexpected stress test output:\n%s\n' "$STRESS_OUTPUT" >&2
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

run_native_test() {
  local name="$1"
  local expected="$2"
  local executable="$TMP/native-$name"
  "$ZUMBRA_BIN" build --release -o "$executable" "tests/${name}_test.zum"
  local output
  output="$("$executable")"
  if [[ "$output" != "$expected" ]]; then
    printf 'Unexpected native %s test output:\n%s\n' "$name" "$output" >&2
    exit 1
  fi
}

run_native_test storage "$STORAGE_EXPECTED"
run_native_test exchange "$EXCHANGE_EXPECTED"
run_native_test preferences "$PREFERENCES_EXPECTED"
run_native_test modal_accessibility "$MODAL_EXPECTED"
run_native_test dialog_layout "$DIALOG_EXPECTED"
run_native_test navigation_charts "$NAVIGATION_EXPECTED"
run_native_test final_polish "$FINAL_POLISH_EXPECTED"
run_native_test sidebar_line_chart "$SIDEBAR_LINE_EXPECTED"
run_native_test stress "$STRESS_EXPECTED"
run_native_test ui_event "$UI_EXPECTED"
run_native_test layout "$LAYOUT_EXPECTED"

mkdir -p "$TMP/vm-data" "$TMP/vm-config"
VM_OUTPUT="$(XDG_DATA_HOME="$TMP/vm-data" XDG_CONFIG_HOME="$TMP/vm-config" ZUMBRA_DESKTOP_HEADLESS=1 "$ZUMBRA_BIN" app run --manifest zumbra.toml)"
VM_EXPECTED=$'collection-ready\n0'
if [[ "$VM_OUTPUT" != "$VM_EXPECTED" ]]; then
  printf 'Unexpected application VM output:\n%s\n' "$VM_OUTPUT" >&2
  exit 1
fi

mkdir -p "$TMP/native-data" "$TMP/native-config"
"$ZUMBRA_BIN" app build --manifest zumbra.toml --target linux --arch amd64 -o "$TMP/zumbra-game-collection"
NATIVE_OUTPUT="$(XDG_DATA_HOME="$TMP/native-data" XDG_CONFIG_HOME="$TMP/native-config" ZUMBRA_DESKTOP_HEADLESS=1 "$TMP/zumbra-game-collection")"
if [[ "$NATIVE_OUTPUT" != "$VM_EXPECTED" ]]; then
  printf 'Unexpected native application output:\n%s\n' "$NATIVE_OUTPUT" >&2
  exit 1
fi

printf 'Z16 game collection tests passed.\n'
