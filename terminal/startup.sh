#!/usr/bin/env bash

tmux_connect="$HOME/.local/bin/tmux-connect"
tmux_paths="$HOME/.nix-profile/bin/tmux"
if [[ -x "$tmux_connect" ]]; then
  "$tmux_connect" --paths "$tmux_paths"
else
  echo "Command not found: $tmux_connect"
  /bin/zsh
fi
