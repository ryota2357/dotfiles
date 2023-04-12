# ログインシェルの時だけに読み込まれる
# PATH は zshrc でもいいけど、export してるから zprofile で十分だと思う

# Homebrew
case $(uname -m) in
  "x86_64" ) eval $(/usr/local/bin/brew shellenv) ;;
  "arm64" ) eval $(/opt/homebrew/bin/brew shellenv) ;;
esac
export FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"

# llvm
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
export LDFLAGS="-L/$HOMEBREW_PREFIX/opt/llvm/lib"
export CPPFLAGS="-I/$HOMEBREW_PREFIX/llvm/include"

# nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# dotnet tools
export PATH="$HOME/.dotnet/tools:$PATH"

# use
export PATH="$HOME/Projects/use/bin:$PATH"