#!/bin/sh

ln_dots() {
  ln -sfnv ~/dotfiles/$1 $2
}

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
ln_dots vim/format/clang-format.yaml ~/.clang-format
for lua_file in $(find ~/dotfiles/vim/rc/*.lua)
do
    file_name=${lua_file##*/}
    ln -sfnv $lua_file ~/.config/nvim/lua/rc/$file_name
done

ln_dots tmux/tmux.conf     ~/.tmux.conf
ln_dots tex/latexmkrc.perl ~/.latexmkrc

unset -f ln_dots
