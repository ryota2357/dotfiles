# brew bump
export HOMEBREW_BUNDLE_FILE="$HOME/.config/brew/Brewfile"

# mocward
export MOCWORD_DATA="$HOME/github/high-moctane/mocword-data/releases/eng20200217/mocword.sqlite"

# tree-sitter config directory
export TREE_SITTER_DIR="$HOME/.config/tree-sitter/"

# man with neovim/vim
# export MANPAGER='nvim +Man!'
export MANPAGER="vim +MANPAGER --not-a-term -"

# fzf <C-r>
export FZF_CTRL_R_OPTS=--reverse

# rust
. "$HOME/.cargo/env"
