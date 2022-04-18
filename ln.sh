#!/bin/sh

ln_dots() {
  ln -sfnv ~/dotfiles/$1 $2
}

mkdir -p ~/.config/nvim/

ln_dots zsh/zshrc.zsh    ~/.zshrc
ln_dots zsh/zprofile.zsh ~/.zprofile
ln_dots tmux/tmux.conf   ~/.tmux.conf
ln_dots vim/vimrc        ~/.config/nvim/init.vim
ln_dots vim/vsvimrc      ~/.vsvimrc

unset -f ln_dots
