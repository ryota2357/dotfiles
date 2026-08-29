#!/usr/bin/env bash

# top's first sample is skewed by its own startup, so read the second one.
CPU=$(top -l 2 -n 0 | awk '/CPU usage/ {usage = $3 + $5} END {printf "%.1f", usage}')
sketchybar --set "$NAME" label="$CPU%"
