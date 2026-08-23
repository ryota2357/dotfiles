#!/usr/bin/env bash

# Install into ~/.terminfo

set -eu

unset CDPATH
cd -- "$(dirname -- "$0")"

tic -x 'screen-256color.ti'
tic -x 'xterm-256color.ti'
tic -x 'tmux-256color.ti'
