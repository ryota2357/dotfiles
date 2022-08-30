if has('nvim')
  command! -nargs=1 -complete=help Vh :vertical belowright help <args>
  command! Wrap setlocal wrap!
endif

" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x

" ビジュアルで選択したテキストにペースト上書きするときにヤンクしない
" `P`だとカーソル移動しないからダメ
xnoremap p pgvy

" インデントを考慮したインサート (ideaにgetline()ない)
if has('nvim')
  nnoremap <expr> i len(getline('.')) !=# 0 ? 'i' : '"_cc'
  nnoremap <expr> a len(getline('.')) !=# 0 ? 'a' : '"_cc'
  nnoremap <expr> A len(getline('.')) !=# 0 ? 'A' : '"_cc'
  nnoremap <expr> I len(getline('.')) !=# 0 ? 'I' : '"_cc'
endif

" 表示行で移動する
if has('nvim')
  nnoremap j gj
  nnoremap k gk
endif

" 行頭行末移動
nnoremap Q ^
nnoremap P $l
vnoremap Q ^
vnoremap P $l

" ノーマルモードでも改行
nnoremap <CR> i<CR><ESC>

" 行選択モードで左右に動いたらビジュアルモードを抜ける (ideaにmode()ない)
if has('nvim')
  vnoremap <expr> h mode() ==# 'V' ? '<Esc>h' : 'h'
  vnoremap <expr> l mode() ==# 'V' ? '<Esc>l' : 'l'
endif

" 行選択モードでShift押したままjk押すことあるので
vnoremap J j
vnoremap K k

" 選択行のインデントをTabでもできるように
vnoremap <Tab> >
vnoremap <S-Tab> <

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

  nmap ,d <Action>(GotoDeclaration)
  nmap ,r <Action>(RenameElement)
  nmap ,a <Action>(ShowIntentionActions)
  nmap ,x <Action>(ShowErrorDescription)
  nnoremap ,l K

  nmap <Leader>f <Action>(GotoFile)
  nmap <Leader>g <Action>(SearchEverywhere)

  nmap ? <Action>(CommentByLineComment)
  vmap ? <Action>(CommentByLineComment)

  command! Format action ReformatCode
  command! Run action Run
endif
