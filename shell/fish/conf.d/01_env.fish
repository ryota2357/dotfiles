# XDG Base Directory (default)
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

# rust
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# man
set -gx MANPAGER "vim +MANPAGER --not-a-term -"
# set -gx MANPAGER 'nvim +Man!'

set -gx LANG 'ja_JP.UTF-8'
set -gx TZ 'Asia/Tokyo'
