# XDG Base Directory
set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME;  or set -x XDG_CACHE_HOME  "$HOME/.cache"
set -q XDG_STATE_HOME;  or set -x XDG_STATE_HOME  "$HOME/.local/state"
set -q XDG_DATA_HOME;   or set -x XDG_DATA_HOME   "$HOME/.local/share"

# rust
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# ghq
set -gx GHQ_ROOT "$HOME/ghq"

# man
set -gx MANPAGER 'vim +MANPAGER --not-a-term -'
# set -gx MANPAGER 'nvim +Man!'

set -gx EDITOR 'vim'
set -gx VISUAL 'vim'

set -gx LANG 'ja_JP.UTF-8'
set -gx LC_ALL 'ja_JP.UTF-8'
set -gx TZ 'Asia/Tokyo'
