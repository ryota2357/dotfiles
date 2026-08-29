#!/usr/bin/env bash

LC_ALL=C printf -v DATE '%(%m/%d %a)T' -1
sketchybar --set "$NAME" label="$DATE"
