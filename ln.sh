#!/bin/sh

set -euo pipefail

ln_dots() {
  dir_path=$(dirname "$2")
  mkdir -p "$dir_path"
  ln -sfnv "$HOME/dotfiles/$1" "$2"
}

# homebrew
mkdir -p ~/.config/brew/
ln_dots Brewfile ~/.config/brew/Brewfile

# zsh
sheldon init --shell zsh
ln_dots zsh/zshrc        ~/.zshrc
ln_dots zsh/zprofile     ~/.zprofile
ln_dots zsh/zshenv       ~/.zshenv
ln_dots zsh/plugins.toml ~/.config/sheldon/plugins.toml

# neovim/ideavim
mkdir -p ~/.config/nvim
ln_dots vim/init.lua                 ~/.config/nvim/init.lua
ln_dots vim/ideavimrc                ~/.config/ideavim/ideavimrc
ln_dots vim/vsvimrc                  ~/.vscode/vimrc
ln_dots vim/vimrc                    ~/.config/vim/vimrc
ln_dots vim/after                    ~/.config/nvim/after
ln_dots vim/denops                   ~/.config/nvim/denops
ln_dots vim/lua                      ~/.config/nvim/lua

# tmux
ln_dots tmux/tmux.conf ~/.config/tmux/tmux.conf

# terminal config
mkdir -p ~/.config/alacritty
ln_dots terminal/alacritty.toml ~/.config/alacritty/alacritty.toml
mkdir -p ~/.config/wezterm
ln_dots terminal/wezterm.lua ~/.config/wezterm/wezterm.lua

# latex
ln_dots config-files/latexmkrc ~/latexmk/latexmkrc

# style
ln_dots style/textlintrc.json   ~/.textlintrc.json
ln_dots style/clang-format.yaml ~/.clang-format

unset -f ln_dots
