#!/usr/bin/env bash
set -euo pipefail

runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
lock_file="${runtime_dir}/hyprlock-launch.lock"

if pgrep -x hyprlock >/dev/null; then
  exit 0
fi

exec 9>"${lock_file}"
flock -n 9 || exit 0

if pgrep -x hyprlock >/dev/null; then
  exit 0
fi

exec hyprlock --config "${HOME}/.config/hypr/hyprlock.conf" --grace 0
