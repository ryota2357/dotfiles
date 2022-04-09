export CPU_TYPE
case $(uname -m) in
  "x86_64" ) CPU_TYPE=Intel ;;
  "arm64" ) CPU_TYPE=Apple ;;
esac

# Homebrew
case "$CPU_TYPE" in
  "Intel" ) eval $(/usr/local/bin/brew shellenv) ;;
  "Apple" ) eval $(/opt/homebrew/bin/brew shellenv) ;;
esac

# zplug
case "$CPU_TYPE" in
  "Intel" ) ;;
  "Apple" ) source /opt/homebrew/opt/zplug/init.zsh ;;
esac

# pyenv
eval "$(pyenv init --path)"
export PATH="${PATH//$(pyenv root)\/shims:/}"
