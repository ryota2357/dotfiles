# rust
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# man
set -gx MANPAGER "vim +MANPAGER --not-a-term -"
# set -gx MANPAGER 'nvim +Man!'
