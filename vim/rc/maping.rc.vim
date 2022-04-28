if has("nvim")
 " vim help を垂直分割で開く
 command! -nargs=1 -complete=help Vh :vertical belowright help <args>
endif

" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x

" Qで行頭, Pで行末に移動
nnoremap Q ^
nnoremap P $l

" ノーマルモードでも改行
nnoremap <CR> i<CR><ESC>

" emacsキーバインド
" C-p, C-n は ddc(pum) で設定、IdeaVimではなぜかこれだけそのまま使えた
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

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

if has("nvim")
  " 補完
  inoremap { {}<Left>
  inoremap {<CR> {<CR>}<ESC><S-o>
  inoremap ( ()<ESC>i
  inoremap (<CR> ()<Left><CR><ESC><S-o>
  inoremap () ()
  inoremap {} {}
  inoremap " ""<Left>
  inoremap ' ''<Left>
  inoremap , ,<Space>
endif

if has('ide')
  " <Action>(action-name) のマッピングには map しか使えない
  " :action action-name<CR> で呼び出せば自由にマッピングできる

  map <Leader>d <Action>(GotoDeclaration)
  map <Leader>r <Action>(RenameElement)
  map <Leader>j <Action>(ShowIntentionActions)
endif
