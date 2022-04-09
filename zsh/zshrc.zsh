source_zsh() {
  source ~/dotfiles/zsh/rc/$1.zsh
}

source_zsh prompt
source_zsh plugin
source_zsh completion
source_zsh option
source_zsh alias

unset -f source_zsh

eval "$(pyenv init -)"
eval "$(rbenv init - zsh)"
