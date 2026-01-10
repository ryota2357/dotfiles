#!/usr/bin/env bash

cd "$1" || exit 1

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "────"
  exit 0
fi

BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

# アイコン付きで出力
echo " $BRANCH"
