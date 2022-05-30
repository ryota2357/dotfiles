# Homebrew
case $(uname -m) in
  "x86_64" ) eval $(/usr/local/bin/brew shellenv) ;;
  "arm64" ) eval $(/opt/homebrew/bin/brew shellenv) ;;
esac

# pyenv
export PATH="${PATH//$(pyenv root)\/shims:/}"
eval "$(pyenv init --path)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
