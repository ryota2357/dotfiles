#!/usr/bin/env bash

set -euo pipefail

ln_dots() {
  local from_path to_path
  from_path="$HOME/dotfiles/$1"
  to_path="$2"
  if [ ! -e "$from_path" ]; then
    echo "Error: $from_path does not exist."
    return 1
  fi
  mkdir -p "$(dirname "$to_path")"
  ln -sfnv "$from_path" "$to_path"
}

# zsh
ln_dots shell/zsh/zshrc          ~/.zshrc
ln_dots shell/zsh/zshenv         ~/.zshenv
ln_dots shell/zsh/alias.zsh      ~/.config/zsh/alias.zsh
ln_dots shell/zsh/completion.zsh ~/.config/zsh/completion.zsh
ln_dots shell/zsh/option.zsh     ~/.config/zsh/option.zsh
ln_dots shell/zsh/prompt.zsh     ~/.config/zsh/prompt.zsh

# fish
ln_dots shell/fish/config.fish   ~/.config/fish/config.fish
ln_dots shell/fish/conf.d        ~/.config/fish/conf.d
ln_dots shell/fish/completions   ~/.config/fish/completions
ln_dots shell/fish/functions     ~/.config/fish/functions
ln_dots shell/fish/prompt.fish   ~/.config/fish/prompt.fish
ln_dots shell/fish/shortcut.fish ~/.config/fish/shortcut.fish

# neovim/ideavim
ln_dots vim/vimrc      ~/.config/vim/vimrc
ln_dots vim/init.lua   ~/.config/nvim/init.lua
ln_dots vim/ideavimrc  ~/.config/ideavim/ideavimrc
ln_dots vim/vsvimrc    ~/.vscode/vimrc
ln_dots vim/after      ~/.config/nvim/after
ln_dots vim/autoload   ~/.config/nvim/autoload
ln_dots vim/denops     ~/.config/nvim/denops
ln_dots vim/ftdetect   ~/.config/nvim/ftdetect
ln_dots vim/lua        ~/.config/nvim/lua

# tmux
ln_dots tmux/tmux.conf ~/.config/tmux/tmux.conf

# terminal
ln_dots config-files/alacritty.toml  ~/.config/alacritty/alacritty.toml
ln_dots config-files/wezterm.lua     ~/.config/wezterm/wezterm.lua

# latex
ln_dots config-files/latexmkrc ~/latexmk/latexmkrc

# style
ln_dots style/textlintrc.json   ~/.textlintrc.json
ln_dots style/clang-format.yaml ~/.clang-format

unset -f ln_dots
