# brew bump
export HOMEBREW_BUNDLE_FILE="$HOME/.config/brew/Brewfile"

# mocward
export MOCWORD_DATA="$HOME/.cache/mocword/mocword.sqlite"
if [[ ! -f $MOCWORD_DATA ]]; then
  URL="https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz"
  echo "mocword data file not found."
  echo "Run the following commands to download and extract the data file."
  mkdir -p "$(dirname $MOCWORD_DATA)"
  echo '  curl -L -o "$MOCWORD_DATA.gz"' "'$URL'"
  echo '  gunzip -f "$MOCWORD_DATA.gz"'
fi

# tree-sitter config directory
export TREE_SITTER_DIR="$HOME/.config/tree-sitter/"

# man with neovim/vim
# export MANPAGER='nvim +Man!'
export MANPAGER="vim +MANPAGER --not-a-term -"

# fzf <C-r>
export FZF_CTRL_R_OPTS=--reverse

# rye shell setup
case ":${PATH}:" in
  *:"$HOME/.rye/shims":*)
    ;;
  *)
    export PATH="$HOME/.rye/shims:$PATH"
    ;;
esac

# rustup shell setup
case ":${PATH}:" in
  *:"$HOME/.cargo/bin":*)
    ;;
  *)
    # Prepending path in case a system-installed rustc needs to be overridden
    export PATH="$HOME/.cargo/bin:$PATH"
    ;;
esac

[ -f ~/.zshenv-local ] && source ~/.zshenv-local
