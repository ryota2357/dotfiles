if not status is-interactive
  return
end

# Homebrew
switch (uname -om)
    case "Darwin x86_64"
        eval (/usr/local/bin/brew shellenv)
    case "Darwin arm64"
        eval (/opt/homebrew/bin/brew shellenv)
    case "*"
        echo "You need to setup Homebrew manually (Unsupported: (uname -om))"
end

# llvm
fish_add_path "$HOMEBREW_PREFIX/opt/llvm/bin"
set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/llvm/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/llvm/include"

direnv hook fish | source
