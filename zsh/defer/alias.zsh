alias c='clang++ -std=c++17 -stdlib=libc++ -Wall -O2'
alias cg='clang++ -std=c++17 -stdlib=libc++ -g3'
alias a='./a.out'

alias ...='cd ../../'

alias clip='pbcopy'

alias vi='nvim'

alias trash='use trash'

mkcd() {
    mkdir -p $1 && cd $1
}

alias denops='deno run -A --no-lock ~/.cache/dein/repos/github.com/vim-denops/denops.vim/denops/@denops-private/cli.ts'
