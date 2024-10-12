if not status is-interactive
  return
end

# Homebrew
switch (uname -sm)
  case 'Darwin arm64'; /opt/homebrew/bin/brew shellenv | source
  case 'Darwin x86_64'; /usr/local/bin/brew shellenv | source
  case '*'; echo "You need to setup Homebrew manually (Unsupported: $(uname -om))"
end

# llvm
fish_add_path "$HOMEBREW_PREFIX/opt/llvm/bin"
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/llvm/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/llvm/include"

# Rust
fish_add_path "$CARGO_HOME/bin"

# fzf
set -gx FZF_CTRL_R_OPTS --reverse
test -f "$XDG_CACHE_HOME/fzf/setup.fish"; and source "$XDG_CACHE_HOME/fzf/setup.fish"
function fzf-fish-setup-init
  mkdir -p "$XDG_CACHE_HOME/fzf/"
  fzf --fish > "$XDG_CACHE_HOME/fzf/setup.fish"
end

# mocward
set -gx MOCWORD_DATA "$XDG_CACHE_HOME/mocword/mocword.sqlite"
function mocword-data-install
  set -l url "https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz"
  set -l zip $MOCWORD_DATA'.gz'
  mkdir -p (dirname $HMOCWORD_DATA)
  curl -L -o $zip $url
  if type -q gnuzip
    gunzip -f $zip
  else
    echo "You need to install 'gunzip' to extract the data file."
    rm -f $zip
    return 1
  end
end

# My Configs
fish_add_path "$HOME/.local/bin"
source "$XDG_CONFIG_HOME/fish/prompt.fish"
source "$XDG_CONFIG_HOME/fish/shortcut.fish"

# eval "$(direnv hook fish)" 2>&1 > /dev/null &
# eval "$(direnv hook fish)"&
direnv hook fish | source
