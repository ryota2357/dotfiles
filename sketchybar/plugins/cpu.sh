#!/usr/bin/env bash

CPU=$(top -l 3 -n 0 | awk '/CPU usage/ {sum += $3 + $5} END {printf "%.1f", sum / 3}')
sketchybar --set "$NAME" label="$CPU%"
