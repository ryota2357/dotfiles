#!/bin/sh

ln_dots() {
  ln -sfnv "$HOME/dotfiles/$1" "$2"
}

# homebrew
mkdir -p ~/.config/brew/
ln_dots Brewfile ~/.config/brew/Brewfile

# zsh
sheldon init --shell zsh
ln_dots zsh/zshrc.zsh    ~/.zshrc
ln_dots zsh/zprofile.zsh ~/.zprofile
ln_dots zsh/zshenv.zsh   ~/.zshenv
ln_dots zsh/plugins.toml ~/.config/sheldon/plugins.toml

# neovim/ideavim
mkdir -p ~/.config/nvim
ln_dots vim/init.lua                 ~/.config/nvim/init.lua
ln_dots vim/ideavimrc                ~/.ideavimrc
ln_dots vim/vsvimrc                  ~/.vscode/vimrc
ln_dots vim/vimrc                    ~/.vimrc
ln_dots vim/after                    ~/.config/nvim/after
ln_dots vim/denops                   ~/.config/nvim/denops
ln_dots vim/lua                      ~/.config/nvim/lua
ln_dots vim/format/clang-format.yaml ~/.clang-format

# tmux
ln_dots tmux/tmux.conf ~/.tmux.conf

# alacritty
mkdir -p ~/.config/alacritty
ln_dots alacritty/alacritty.yaml ~/.config/alacritty/alacritty.yml

# latex
ln_dots tex/latexmkrc.perl ~/.latexmkrc

unset -f ln_dots
