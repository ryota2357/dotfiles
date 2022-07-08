" not impliment yet :(
" let $VIMRC = expand('<sfile>:p')

" define <Leader>
let mapleader = "\<Space>"

execute 'source ~/dotfiles/vim/rc/maping.rc.vim'

set incsearch
set scrolloff=3
set ignorecase
set ideajoin

set NERDTree
nnoremap <Leader>o :<C-u>NERDTreeToggle<CR>
