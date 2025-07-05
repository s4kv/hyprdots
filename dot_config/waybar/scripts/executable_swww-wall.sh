#!/bin/bash
swww-daemon &
sleep 0.1
file=$(find ~/Wallpaper/loop-wall/ -type f | shuf -n 1)

if [[ -n "$file" ]]; then
  matugen image "$file"
fi
# swww img ~/Backgrounds/wallhavpurp.jpg
