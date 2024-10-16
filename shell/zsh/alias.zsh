alias c='clang++ -std=c++17 -stdlib=libc++ -Wall -O2'
alias cg='clang++ -std=c++17 -stdlib=libc++ -g3'
alias a='./a.out'

alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias clip='pbcopy'

alias vi='nvim'
alias :q='exit'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

mkcd() {
  mkdir -p $1 && cd $1
}

git() {
  if [ $# -eq 0 ]; then
    lazygit
  else
    command git "$@"
  fi
}

alias denops='deno run -A --no-lock ~/.cache/dein/repos/github.com/vim-denops/denops.vim/denops/@denops-private/cli.ts'
