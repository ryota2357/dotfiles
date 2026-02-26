#!/usr/bin/env bash

input=$(cat)

IFS=$'\n' read -r -d '' message title <<EOF
$(jq -r '
  (.message // "Claude Code needs your attention"),
  (.title // "Claude Code")
' <<< "$input")
EOF

message="${message//\"/\\\"}"
title="${title//\"/\\\"}"
osascript << APPLESCRIPT
  display notification "$message" with title "$title" sound name "Glass"
APPLESCRIPT
