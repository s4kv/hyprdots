#!/usr/bin/env bash
set -euo pipefail

state_dir="${XDG_STATE_HOME:-${HOME}/.local/state}/hypr"
log_file="${state_dir}/waybar.log"

mkdir -p "${state_dir}"
pkill -x waybar >/dev/null 2>&1 || true

for _ in {1..20}; do
  pgrep -x waybar >/dev/null 2>&1 || break
  sleep 0.1
done

nohup waybar \
  --config "${HOME}/.config/waybar/config.jsonc" \
  --style "${HOME}/.config/waybar/style.css" \
  >"${log_file}" 2>&1 &

for _ in {1..30}; do
  pgrep -x waybar >/dev/null 2>&1 && exit 0
  sleep 0.1
done

printf 'Waybar did not remain running; see %s\n' "${log_file}" >&2
exit 1
