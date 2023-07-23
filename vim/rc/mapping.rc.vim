if has('nvim')
  command! -nargs=1 -complete=help Vh :vertical belowright help <args>
  command! Wrap setlocal wrap!
  command! FixWhitespace silent! keepjumps execute ':%s/\\\@<!\s\+$//'
endif

" <Leader>、`'`で囲うとダメみたい
let mapleader = "\<Space>"

" xで削除した時はヤンクしない
xnoremap x "_x
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
nnoremap 0 ^
nnoremap ^ 0
nnoremap + $
xnoremap 0 ^
xnoremap ^ 0
xnoremap + $

" ペア移動
nnoremap ] %

" ノーマルモードでも改行
nnoremap <CR> i<CR><ESC>

" 行選択モードで左右に動いたらビジュアルモードを抜ける (ideaにmode()ない)
if has('nvim')
  xnoremap <expr> h mode() ==# 'V' ? '<Esc>h' : 'h'
  xnoremap <expr> l mode() ==# 'V' ? '<Esc>l' : 'l'
endif

" 行選択モードでShift押したままjk押すことあるので
xnoremap J j
xnoremap K k

" 選択行のインデントをTabでもできるように
xnoremap <Tab> >
xnoremap <S-Tab> <

" :q のタイポ修正
nnoremap q: :q
nnoremap <Leader>: q:

" emacsキーバインド
" C-p, C-n は ddc(pum) で設定、IdeaVimではなぜかこれだけそのまま使えた
for key in [['b', '<C-G>U<Left>'],
         \  ['f', '<C-G>U<Right>'],
         \  ['a', '<Home>'],
         \  ['e', '<End>'],
         \  ['d', '<Del>'],
         \  ['h', '<BS>'],
         \  ['k', '<Cmd>normal! "_D<CR><End>']]
    execute 'inoremap <C-' .. key[0] .. '> ' .. key[1]
    execute 'cnoremap <C-' .. key[0] .. '> ' .. key[1]
endfor
" <ESC>"_DA だと上手くいかない...どうしたらいい？
" ひとまず無効化しておく
if has("ide")
  inoremap <C-b> <Left>
  inoremap <C-f> <Right>
  inoremap <C-k> <C-k>
  cnoremap <C-k> <C-k>
endif

" めっちゃ誤爆させるので
nnoremap <C-f> <Nop>

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

" モーション
for motion in [['i2', 'i"'], ['i7', "i'"], ['i8', 'i('], ['i9', 'i)'],
            \  ['a2', '2i"'], ['a7', "2i'"], ['a8', 'a('], ['a9', 'a)'], ['a`', '2i`']]
  execute 'onoremap ' .. motion[0] .. ' ' .. motion[1]
  execute 'xnoremap ' .. motion[0] .. ' ' .. motion[1]
endfor
for motion in ['f', 't', 'F', 'T']
  for char in [['1', '!'], ['2', '"'], ['3', '#'], ['4', '$'], ['5', '%'], ['6', '&'], ['7', "'"], ['8', '('], ['9', ')']]
    execute 'nnoremap ' .. motion .. char[0] .. ' ' .. motion .. char[1]
    execute 'nnoremap ' .. motion .. char[1] .. ' ' .. motion .. char[0]
    execute 'onoremap ' .. motion .. char[0] .. ' ' .. motion .. char[1]
    execute 'onoremap ' .. motion .. char[1] .. ' ' .. motion .. char[0]
    execute 'xnoremap ' .. motion .. char[0] .. ' ' .. motion .. char[1]
    execute 'xnoremap ' .. motion .. char[1] .. ' ' .. motion .. char[0]
  endfor
endfor

" タブ移動
if has('nvim')
  nnoremap > <Cmd>tabn<CR>
  nnoremap < <Cmd>tabN<CR>
elseif has('ide')
  nnoremap > :<C-u>tabn<CR>
  nnoremap < :<C-u>tabN<CR>
endif

" 文字コード入力
inoremap <C-v>u <C-r>=nr2char(0x)<Left>
