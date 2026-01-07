#!/usr/bin/env bash

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100)   ICON="􀊩" ;; # speaker.wave.3.fill
    [3-5][0-9])       ICON="􀊧" ;; # speaker.wave.2.fill
    [1-9]|[1-2][0-9]) ICON="􀊥" ;; # speaker.wave.1.fill
    *)                ICON="􀊣" ;; # speaker.slash.fill
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
