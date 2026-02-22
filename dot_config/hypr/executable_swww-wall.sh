#!/bin/bash
swww-daemon &
sleep 2
file=$(find ~/Wallpaper/loop-wall/ -type f | shuf -n 1)

if [[ -n "$file" ]]; then
  # this will also handle the start of waybar
  matugen image "$file" --source-color-index 0
fi
# swww img ~/Backgrounds/wallhavpurp.jpg
