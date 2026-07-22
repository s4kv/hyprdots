#!/usr/bin/env bash
set -euo pipefail

state_dir="${XDG_STATE_HOME:-${HOME}/.local/state}/hypr"

mkdir -p "${state_dir}"

if ! awww query >/dev/null 2>&1; then
  pkill -x awww-daemon >/dev/null 2>&1 || true
  awww-daemon --quiet >"${state_dir}/awww-daemon.log" 2>&1 &
fi

for _ in {1..50}; do
  awww query >/dev/null 2>&1 && break
  sleep 0.1
done

if ! awww query >/dev/null 2>&1; then
  printf 'awww-daemon did not become ready; see %s\n' "${state_dir}/awww-daemon.log" >&2
  exit 1
fi

wallpaper=$(find "${HOME}/Wallpaper/loop-wall" -type f -print0 | shuf -z -n 1 | tr -d '\0')

if [[ -n "${wallpaper}" ]]; then
  # Global Matugen also remembers this choice in boot-wall.sh.
  exec matugen image "${wallpaper}" --source-color-index 0
fi

# Previous manual wallpaper command:
# swww img ~/Backgrounds/wallhavpurp.jpg
