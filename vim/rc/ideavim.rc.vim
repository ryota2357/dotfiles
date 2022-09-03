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

" <Action>(action-name) のマッピングには map しか使えない
" :action action-name<CR> で呼び出せば自由にマッピングできる
nmap ,d <Action>(GotoDeclaration)
nmap ,r <Action>(RenameElement)
nmap ,a <Action>(ShowIntentionActions)
nmap ,x <Action>(ShowErrorDescription)
nnoremap ,l K
nmap <Leader>f <Action>(GotoFile)
nmap <Leader>g <Action>(SearchEverywhere)
nmap ? <Action>(CommentByLineComment)
vmap ? <Action>(CommentByLineComment)

set NERDTree
nnoremap <Leader>o :<C-u>NERDTreeToggle<CR>

command! Format action ReformatCode
command! Run action Run
