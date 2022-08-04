#!/bin/sh

ln_dots() {
  ln -sfnv ~/dotfiles/$1 $2
}

mkdir -p ~/.config/nvim/
sheldon init --shell zsh

ln_dots zsh/zshrc.zsh                ~/.zshrc
ln_dots zsh/zprofile.zsh             ~/.zprofile
ln_dots zsh/plugins.toml             ~/.sheldon/plugins.toml
ln_dots tmux/tmux.conf               ~/.tmux.conf
ln_dots vim/init.lua                 ~/.config/nvim/init.lua
ln_dots vim/vimrc                    ~/.ideavimrc
ln_dots vim/after                    ~/.config/nvim/after
ln_dots vim/format/clang-format.yaml ~/.clang-format
ln_dots tex/latexmkrc.perl           ~/.latexmkrc

unset -f ln_dots
