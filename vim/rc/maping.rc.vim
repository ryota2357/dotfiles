if has('nvim')
  command! -nargs=1 -complete=help Vh :vertical belowright help <args>
  command! Wrap setlocal wrap!
endif

" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x

" 表示行で移動する
if has('nvim')
  nnoremap j gj
  nnoremap k gk
endif

" 移動系
nnoremap Q ^
nnoremap P $l
vnoremap Q ^
vnoremap P $l
nnoremap ;; ;

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
nnoremap ss <Cmd>sp<CR><C-w>j"
nnoremap sv <Cmd>vs<CR><C-w>l
nnoremap <C-w>j <C-w>-
nnoremap <C-W>k <C-w>+
nnoremap <C-w>l <C-w>>
nnoremap <C-w>h <C-w><

" タブ移動
if has('nvim')
  nnoremap > <Cmd>tabn<CR>
  nnoremap < <Cmd>tabN<CR>
elseif has('ide')
  nnoremap > :<C-u>tabn<CR>
  nnoremap < :<C-u>tabN<CR>
endif

if has('ide')
  " <Action>(action-name) のマッピングには map しか使えない
  " :action action-name<CR> で呼び出せば自由にマッピングできる

  nmap ;d <Action>(GotoDeclaration)
  nmap ;r <Action>(RenameElement)
  nmap ;a <Action>(ShowIntentionActions)
  nmap ;x <Action>(ShowErrorDescription)
  nnoremap ;l K

  nmap <Leader>f <Action>(GotoFile)
  nmap <Leader>g <Action>(SearchEverywhere)

  nmap ? <Action>(CommentByLineComment)
  vmap ? <Action>(CommentByLineComment)
endif
