# XDG Base Directory
set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME;  or set -x XDG_CACHE_HOME  "$HOME/.cache"
set -q XDG_STATE_HOME;  or set -x XDG_STATE_HOME  "$HOME/.local/state"
set -q XDG_DATA_HOME;   or set -x XDG_DATA_HOME   "$HOME/.local/share"

set -gx EDITOR 'vim'
set -gx VISUAL 'vim'

set -gx LANG 'ja_JP.UTF-8'
set -gx LC_ALL 'ja_JP.UTF-8'
set -gx TZ 'Asia/Tokyo'

# man
set -gx MANPAGER 'vim +MANPAGER --not-a-term -'
# set -gx MANPAGER 'nvim +Man!'

# Rust
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# Go
set -gx GOPATH "$XDG_DATA_HOME/go"

# Haskell
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
set -gx STACK_XDG 1

# OCaml
set -gx OPAMROOT "$XDG_DATA_HOME/opam"

# Node.js
set -gx NODE_REPL_HISTORY "$XDG_STATE_HOME/node_repl_history"
set -gx NPM_CONFIG_INIT_MODULE "$XDG_CONFIG_HOME/npm/config/npm-init.js"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
# set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"

# ghq
set -gx GHQ_ROOT "$HOME/ghq"
