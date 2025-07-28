#!/usr/bin/env bash
# hypr-rofi-bring-here.sh
# Requirements hyprctl, jq, rofi
set -euo pipefail

CUR_WS=$(hyprctl activeworkspace -j | jq '.id')      # current workspace id
SEL=$(hyprctl clients -j |
      jq -r '.[] | [.address,.workspace.name,.class,.title] | @tsv' |
      rofi -dmenu -i -p "send → workspace $CUR_WS" -theme ~/.config/rofi/rofi-focus/style.rasi  |
      cut -f1)

[[ -z "$SEL" ]] && exit 0                            # user aborted

hyprctl dispatch movetoworkspacesilent "$CUR_WS",address:"$SEL"
# hyprctl dispatch focuswindow address:"$SEL"
