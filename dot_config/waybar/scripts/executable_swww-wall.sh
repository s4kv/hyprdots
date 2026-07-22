#!/usr/bin/env bash
set -euo pipefail

# Keep the legacy filename used by Waybar, but use the current awww pipeline.
exec "${HOME}/.config/hypr/swww-wall.sh"
