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
mkdir -p ~/.config/nvim/lua/rc/
ln_dots vim/init.lua                 ~/.config/nvim/init.lua
ln_dots vim/vimrc                    ~/.ideavimrc
ln_dots vim/after                    ~/.config/nvim/after
ln_dots vim/denops                   ~/.config/nvim/denops
ln_dots vim/format/clang-format.yaml ~/.clang-format
find "$HOME/dotfiles/vim/rc/*.lua" | while read -r lua_file
do
    file_name=${lua_file##*/}
    ln -sfnv "$lua_file" "$HOME/.config/nvim/lua/rc/$file_name"
done

# tmux
ln_dots tmux/tmux.conf ~/.tmux.conf

# latex
ln_dots tex/latexmkrc.perl ~/.latexmkrc

unset -f ln_dots
