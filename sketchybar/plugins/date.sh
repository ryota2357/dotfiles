#!/usr/bin/env bash

DATE=$(LC_ALL=C date '+%m/%d %a')
sketchybar --set "$NAME" label="$DATE"
