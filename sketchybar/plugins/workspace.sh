#!/usr/bin/env bash

if [ -n "$FOCUSED_WORKSPACE" ]; then
  FOCUSED="$FOCUSED_WORKSPACE"
else
  AEROSPACE="$(brew --prefix)/bin/aerospace"
  FOCUSED=$("$AEROSPACE" list-workspaces --focused 2>/dev/null || echo "?")
fi

if [ "$FOCUSED" = "?" ]; then
  exit 0
fi

SID=${NAME#workspace.}
if [ "$FOCUSED" = "$SID" ]; then
  sketchybar --set "$NAME" label.color=0xffffffff
else
  sketchybar --set "$NAME" label.color=0x60ffffff
fi
