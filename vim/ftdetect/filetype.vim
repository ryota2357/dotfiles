let g:tex_flavor = 'latex'

autocmd BufRead,BufNewFile CMakeLists.txt setlocal filetype=cmake
autocmd BufRead,BufNewFile *.tmux setlocal filetype=tmux
