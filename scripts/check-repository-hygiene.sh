#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
for directory in build dist out tmp tools; do
  if [[ -e "$ROOT/$directory" ]]; then
    printf 'Generated directory must not be committed: %s\n' "$directory" >&2
    exit 1
  fi
done
if find "$ROOT" -type f \( -name '*.sqlite' -o -name '*.sqlite-shm' -o -name '*.sqlite-wal' \) -print -quit | grep -q .; then
  printf 'Local SQLite data must not be committed.\n' >&2
  exit 1
fi
if find "$ROOT" -type f -size +5M -print -quit | grep -q .; then
  printf 'Repository contains an individual file larger than 5 MB.\n' >&2
  exit 1
fi
printf 'Game collection repository hygiene checks passed.\n'
