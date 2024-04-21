# source command override technique
function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "\033[1;36mCompiling\033[m $1"
    zcompile $1
  fi
}
ensure_zcompiled ~/.zshrc
ensure_zcompiled ~/.zshenv
ensure_zcompiled ~/.zprofile

# sheldon cache technique
() {
  local sheldon_cache="$HOME/.cache/zsh/sheldon.zsh"
  local sheldon_toml="$HOME/dotfiles/zsh/plugins.toml"
  if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
      mkdir -p "$(dirname "$sheldon_cache")"
      sheldon source > "$sheldon_cache"
  fi
  source "$sheldon_cache"
}

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
zsh-defer unfunction source
