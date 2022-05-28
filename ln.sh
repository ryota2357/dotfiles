#!/bin/sh

ln_dots() {
  ln -sfnv ~/dotfiles/$1 $2
}

mkdir -p ~/.config/nvim/
sheldon init --shell zsh

ln_dots zsh/zshrc.zsh      ~/.zshrc
ln_dots zsh/zprofile.zsh   ~/.zprofile
ln_dots zsh/plugins.toml   ~/.sheldon/plugins.toml
ln_dots tmux/tmux.conf     ~/.tmux.conf
ln_dots vim/vimrc          ~/.config/nvim/init.vim
ln_dots vim/vimrc          ~/.ideavimrc
ln_dots tex/latexmkrc.perl ~/.latexmkrc

unset -f ln_dots