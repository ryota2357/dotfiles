#!/usr/bin/env bash

osascript << APPLESCRIPT
  display notification "Claude has finished responding." with title "Claude Code" sound name "Glass"
APPLESCRIPT
