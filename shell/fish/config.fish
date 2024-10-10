if not status is-interactive
  return
end

# Homebrew
switch (uname -sm)
    case "Darwin x86_64"
        /usr/local/bin/brew shellenv | source
    case "Darwin arm64"
        /opt/homebrew/bin/brew shellenv | source
    case "*"
        echo "You need to setup Homebrew manually (Unsupported: $(uname -om))"
end

# llvm
fish_add_path "$HOMEBREW_PREFIX/opt/llvm/bin"
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/llvm/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/llvm/include"

# Rust
fish_add_path "$CARGO_HOME/bin"

fish_add_path "$HOME/.local/bin"
source "$XDG_CONFIG_HOME/fish/prompt.fish"
source "$XDG_CONFIG_HOME/fish/shortcut.fish"

# eval "$(direnv hook fish)" 2>&1 > /dev/null &
# eval "$(direnv hook fish)"&
direnv hook fish | source
