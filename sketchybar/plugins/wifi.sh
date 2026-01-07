#!/usr/bin/env bash

if networksetup -getairportpower en0 | grep -q ": Off"; then
  sketchybar --set "$NAME" icon='􀙈' # wifi.slash
elif route -n get default 2>/dev/null | grep -q "gateway: 172.20.10.1"; then
  sketchybar --set "$NAME" icon='􀉤' # personalhotspot
else
  sketchybar --set "$NAME" icon='􀙇' # wifi
fi
