# Homebrew
# llvm
case $(uname -m) in
  "x86_64" )
      eval $(/usr/local/bin/brew shellenv)
      export PATH="/usr/local/opt/llvm/bin:$PATH"
      ;;
  "arm64" )
      eval $(/opt/homebrew/bin/brew shellenv)
      export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
      ;;
esac

# pyenv
export PATH="${PATH//$(pyenv root)\/shims:/}"
eval "$(pyenv init --path)"

# nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# use
export PATH="$HOME/Projects/use/bin:$PATH"
