#!/bin/bash
awww-daemon &
sleep 2
# this will also handle the start of waybar
matugen image "{{image}}" --source-color-index 0
# awww img ~/Backgrounds/wallhavpurp.jpg
