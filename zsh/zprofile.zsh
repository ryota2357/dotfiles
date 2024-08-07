# Homebrew
case $(uname -om) in
  "Darwin x86_64" ) eval $(/usr/local/bin/brew shellenv) ;;
  "Darwin arm64" ) eval $(/opt/homebrew/bin/brew shellenv) ;;
  * ) echo "You need to setup Homebrew manually (Unsupported: $(uname -om))" ;;
esac

# llvm
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/llvm/include"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# dotnet tools
export PATH="$HOME/.dotnet/tools:$PATH"

# use
export PATH="$HOME/Projects/use/bin:$PATH"
