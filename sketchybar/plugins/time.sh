#!/usr/bin/env bash

TIME=$(date '+%H:%M:%S')
sketchybar --set "$NAME" label="$TIME"

[[ "${TIME%:*}" =~ ^(23:59|00:00)$ ]] && sketchybar --trigger date_boundary
