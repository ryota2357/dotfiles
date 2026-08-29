#!/usr/bin/env bash

PMSET_OUTPUT=$(pmset -g batt)

if [[ ! $PMSET_OUTPUT =~ ([0-9]+)% ]]; then
  exit 0
fi
PERCENTAGE=${BASH_REMATCH[1]}

case "$PERCENTAGE" in
  100)    ICON="󰁹"; COLOR="0xff4caf50" ;; #4caf50
  9[0-9]) ICON="󰂂"; COLOR="0xff4caf50" ;;
  8[0-9]) ICON="󰂁"; COLOR="0xff80e27e" ;; #80e27e
  7[0-9]) ICON="󰂀"; COLOR="0xff80e27e" ;;
  6[0-9]) ICON="󰁿"; COLOR="0xff80e27e" ;;
  5[0-9]) ICON="󰁾"; COLOR="0xffbef67a" ;; #bef67a
  4[0-9]) ICON="󰁽"; COLOR="0xffbef67a" ;;
  3[0-9]) ICON="󰁼"; COLOR="0xffbef67a" ;;
  2[0-9]) ICON="󰁻"; COLOR="0xffffeb3b" ;; #ffeb3b
  1[1-9]) ICON="󰁺"; COLOR="0xffffeb3b" ;;
  *)      ICON="󰂎"; COLOR="0xffff0000" ;; #ff0000
esac

if [[ $PMSET_OUTPUT == *"AC Power"* ]]; then
  ICON=""
fi

sketchybar --set "$NAME" icon="$ICON" label="$PERCENTAGE%" label.color="$COLOR"
