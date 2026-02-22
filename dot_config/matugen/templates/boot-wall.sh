#!/bin/bash
swww-daemon &
sleep 2
# this will also handle the start of waybar
matugen image "{{image}}" --source-color-index 0
# swww img ~/Backgrounds/wallhavpurp.jpg
