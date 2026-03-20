#!/usr/bin/env bash

TIME=$(date '+%H:%M:%S')
sketchybar --set "$NAME" label="$TIME"

if [[ "${TIME%:*}" =~ ^(23:59|00:00)$ ]]; then
  sketchybar --trigger date_boundary
fi
