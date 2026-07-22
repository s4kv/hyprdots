#!/usr/bin/env bash
set -euo pipefail

wallpaper="/home/sakvi/Wallpaper/loop-wall/sand.png"
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

# Global Matugen sets the wallpaper, generates all application themes, reloads
# Hyprland, and starts/restarts Waybar.
exec matugen image "${wallpaper}" --source-color-index 0

# Previous manual wallpaper command:
# awww img ~/Backgrounds/wallhavpurp.jpg
