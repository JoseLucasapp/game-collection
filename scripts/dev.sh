#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

APP_PID=""
LAST_FINGERPRINT=""

cleanup() {
  if [[ -n "${APP_PID:-}" ]] && kill -0 "$APP_PID" 2>/dev/null; then
    kill "$APP_PID" 2>/dev/null || true
    wait "$APP_PID" 2>/dev/null || true
  fi
}

trap cleanup EXIT INT TERM

fingerprint() {
  {
    printf '%s\0' "zumbra.toml"

    for directory in src assets vendor; do
      if [[ -d "$directory" ]]; then
        find "$directory" \
          -type f \
          \( \
            -name '*.zum' \
            -o -name '*.toml' \
            -o -name '*.png' \
            -o -name '*.ico' \
            -o -name '*.icns' \
          \) \
          -print0
      fi
    done
  } |
    sort -z |
    xargs -0 sha256sum 2>/dev/null |
    sha256sum |
    cut -d' ' -f1
}

start_app() {
  printf '\n[dev] Iniciando aplicação pela VM...\n'

  zumbra app run --manifest zumbra.toml &
  APP_PID=$!

  sleep 0.5

  if ! kill -0 "$APP_PID" 2>/dev/null; then
    wait "$APP_PID" || true
    APP_PID=""
    printf '[dev] A aplicação terminou durante a inicialização.\n'
    return 1
  fi

  printf '[dev] Aplicação iniciada. PID: %s\n' "$APP_PID"
}

restart_app() {
  printf '\n[dev] Alteração detectada. Reiniciando...\n'

  if [[ -n "${APP_PID:-}" ]] && kill -0 "$APP_PID" 2>/dev/null; then
    kill "$APP_PID" 2>/dev/null || true
    wait "$APP_PID" 2>/dev/null || true
  fi

  APP_PID=""
  start_app || true
}

start_app || true
LAST_FINGERPRINT="$(fingerprint)"

printf '[dev] Observando src/, assets/, vendor/ e zumbra.toml...\n'
printf '[dev] Pressione Ctrl+C para encerrar.\n'

while sleep 0.5; do
  CURRENT_FINGERPRINT="$(fingerprint)"

  if [[ "$CURRENT_FINGERPRINT" != "$LAST_FINGERPRINT" ]]; then
    sleep 0.2
    LAST_FINGERPRINT="$(fingerprint)"
    restart_app
  fi
done