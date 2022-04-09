" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x

" Qで行頭, Pで行末に移動
nnoremap Q ^
nnoremap P $l

nnoremap <CR> i<CR><ESC>

" emacsキーバインド
" C-p, C-n は ddc(pum) で設定
" inoremap <C-p> <Up>
" inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <ESC>^i
inoremap <C-e> <ESC>$li
inoremap <C-d> <Del>
inoremap <C-h> <BS>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" 画面分割/移動
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR><C-w>j"
nnoremap sv :<C-u>vs<CR><C-w>l
nnoremap <C-w>j <C-w>-
nnoremap <C-W>k <C-w>+
nnoremap <C-w>l <C-w>>
nnoremap <C-w>h <C-w><

" タブ移動
nnoremap > :tabn<CR>
nnoremap < :tabN<CR>

" 補完
inoremap { {}<Left>
inoremap {<Enter> {<CR>}<ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap () ()
inoremap {} {}
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap , ,<Space>
