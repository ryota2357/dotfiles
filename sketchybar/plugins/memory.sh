#!/usr/bin/env bash

vm_stat2="$HOME/.nix-profile/bin/vm_stat2"
MEMORY=$("$vm_stat2" | awk '/Used Memory:/ {gsub(/[()%]/, "", $5); print $5}')
sketchybar --set "$NAME" label="$MEMORY%"
