#!/usr/bin/env bash
# Usage: smart_layout.sh [focus|swap|resize] [l|r|u|d/h/j/k]

ACTION=$1
DIR=$2

# 1. Try to get the layout from workspace rules 
ACTIVE_WS=$(hyprctl -j activeworkspace | jq -r '.name')
LAYOUT=$(hyprctl -j workspacerules | jq -r '.[] | select(.workspaceString == "'"$ACTIVE_WS"'") | .layout // empty' | head -n 1)

# 2. If no workspace rule defines a layout, get the global layout
if [[ -z "$LAYOUT" || "$LAYOUT" == "null" ]]; then
    LAYOUT=$(hyprctl -j getoption general:layout | jq -r '.str')
fi

if [[ "$LAYOUT" == "scrolling" ]]; then
    # --- SCROLLING LAYOUT LOGIC ---
    if [[ "$ACTION" == "focus" ]]; then
        hyprctl dispatch layoutmsg focus "$DIR"
    elif [[ "$ACTION" == "swap" ]]; then
        # if [[ "$DIR" == "l" || "$DIR" == "r" ]]; then
        #     hyprctl dispatch layoutmsg swapcol "$DIR"
        # else
        hyprctl dispatch swapwindow "$DIR"
        # fi
    elif [[ "$ACTION" == "resize" ]]; then
        if [[ "$DIR" == "l" ]]; then
            hyprctl dispatch -- layoutmsg colresize +conf
        elif [[ "$DIR" == "h" ]]; then
            hyprctl dispatch -- layoutmsg colresize -conf
        elif [[ "$DIR" == "k" ]]; then
            hyprctl dispatch resizeactive 0 -33%
        elif [[ "$DIR" == "j" ]]; then
            hyprctl dispatch resizeactive 0 33%
        fi
    fi
else
    # --- DWINDLE (OR DEFAULT) LOGIC ---
    if [[ "$ACTION" == "focus" ]]; then
        hyprctl dispatch movefocus "$DIR"
    elif [[ "$ACTION" == "swap" ]]; then
        hyprctl dispatch swapwindow "$DIR"
    elif [[ "$ACTION" == "resize" ]]; then
        if [[ "$DIR" == "l" ]]; then
            hyprctl dispatch resizeactive 33% 0
        elif [[ "$DIR" == "h" ]]; then
            hyprctl dispatch resizeactive -33% 0
        elif [[ "$DIR" == "k" ]]; then
            hyprctl dispatch resizeactive 0 -33%
        elif [[ "$DIR" == "j" ]]; then
            hyprctl dispatch resizeactive 0 33%
        fi
    fi
fi
