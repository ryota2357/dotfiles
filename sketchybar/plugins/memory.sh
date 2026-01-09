#!/usr/bin/env bash

MEMORY=$(vm_stat2 | awk '/Used Memory:/ {gsub(/[()%]/, "", $5); print $5}')
sketchybar --set "$NAME" label="$MEMORY%"
