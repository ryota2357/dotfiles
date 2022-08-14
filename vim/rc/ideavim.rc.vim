" not impliment yet :(
" let $VIMRC = expand('<sfile>:p')

" define <Leader>
let mapleader = "\<Space>"

execute 'source ~/dotfiles/vim/rc/maping.rc.vim'

set incsearch
set scrolloff=3
set ignorecase
set ideajoin
set clipboard=unnamed

" lexima.vim 使いたい...
inoremap ( ()<Left>
inoremap () ()
inoremap " ""<Left>
inoremap "" ""
inoremap [ []<Left>
inoremap [] []

set NERDTree
nnoremap <Leader>o :<C-u>NERDTreeToggle<CR>
