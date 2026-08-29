#!/usr/bin/env bash

printf -v TIME '%(%H:%M:%S)T' -1
sketchybar --set "$NAME" label="$TIME"

if [[ $TIME == 00:00:0? ]]; then
  sketchybar --trigger date_boundary
fi
