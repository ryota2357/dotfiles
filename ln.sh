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

# tmux
ln_dots tmux/tmux.conf ~/.tmux.conf

# terminal config
mkdir -p ~/.config/alacritty
ln_dots terminal/alacritty.yaml ~/.config/alacritty/alacritty.yml
mkdir -p ~/.config/wezterm
ln_dots terminal/wezterm.lua ~/.config/wezterm/wezterm.lua

# latex
ln_dots tex/latexmkrc.perl ~/.latexmkrc

# tree-sitter
ln_dots tree-sitter/config.json ~/.config/tree-sitter/config.json

# style
ln_dots style/textlintrc.json   ~/.textlintrc.json
ln_dots style/clang-format.yaml ~/.clang-format

unset -f ln_dots
