if has('nvim')
  command! -nargs=1 -complete=help Vh :vertical belowright help <args>
  command! Wrap setlocal wrap!
  command! FixWhitespace silent! keepjumps execute ':%s/\\\@<!\s\+$//'

  function! s:keycode(keys) abort
    return substitute(a:keys, '<[^>]*>', '\=eval(''"\'' .. submatch(0) .. ''"'')', 'g')
  endfunction
endif

" <Leader>、`'`で囲うとダメみたい
let mapleader = "\<Space>"

" xで削除した時はヤンクしない
xnoremap x "_x
nnoremap x "_x

" 行末まで削除 (CやDと動作をそろえる)
nnoremap X "_D

" 行末までヤンク (neovimはデフォルトマッピング :h default-mappings)
nnoremap Y y$

" ビジュアルで選択したテキストにペースト上書きするときにヤンクしない
" `P`だとカーソル移動しないからダメ
xnoremap p pgvy

" redo (u で undo の逆 (デフォルトのUは使わないので潰す))
nnoremap U <C-r>

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
  nnoremap <Up> g<Up>
  nnoremap <Down> g<Down>
endif

" 行頭行末移動
for mode in ['n', 'x']
  execute mode .. 'noremap 0 ^'
  execute mode .. 'noremap ^ 0'
  execute mode .. 'noremap + $'
endfor

" 括弧ジャンプ (デフォルトのMは使わないので潰す)
nnoremap M %
xnoremap M %

" if has('nvim')
"   nnoremap <silent><expr> * v:count ? '*' : ':sil exe "keepj norm! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'
" endif

" ノーマルモードでも改行
" nnoremap <CR> i<CR><ESC>

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
if has('ide')
  inoremap <C-b> <Left>
  inoremap <C-f> <Right>
  inoremap <C-k> <C-k>
  cnoremap <C-k> <C-k>
endif

" めっちゃ誤爆させるので
nnoremap <C-f> <Nop>

" 画面分割
if has('ide')
  nnoremap ss :<C-u>sp<CR>
  nnoremap sv :<C-u>vs<CR>
else
  nnoremap ss <Cmd>sp<CR><C-w>j
  nnoremap sv <Cmd>vs<CR><C-w>l
end

" ウィンドウサイズの変更
" TODO: これだと、edge 方向が tmux だった時の変更ができない
nmap <Plug>(window-resize-mode) <Nop>
function! s:has_edge(direct) abort
  if a:direct ==# 'left'
    return winnr('h') != winnr()
  elseif a:direct ==# 'down'
    return winnr('j') != winnr()
  elseif a:direct ==# 'up'
    return winnr('k') != winnr()
  elseif a:direct ==# 'right'
    return winnr('l') != winnr()
  endif
  echoerr 'invalid direct'
  return false
endfunction
function! s:win_resize_count_cmd_with_update(direct, count1) abort
  let l:signs = #{ left: '-', down: '+', up: '-', right: '+' }
  if s:has_edge('left') && !s:has_edge('right')
    let l:signs['left'] = '+'
    let l:signs['right'] = '-'
  endif
  if s:has_edge('up') && !s:has_edge('down')
    let l:signs['up'] = '+'
    let l:signs['down'] = '-'
  endif
  let s:win_resize_cmd_dict = #{
      \ left:  s:keycode('<Cmd>vertical resize ' .. l:signs['left'] .. '1<CR>'),
      \ right: s:keycode('<Cmd>vertical resize ' .. l:signs['right'] .. '1<CR>'),
      \ down:  s:keycode('<Cmd>resize ' .. l:signs['down'] .. '1<CR>'),
      \ up:    s:keycode('<Cmd>resize ' .. l:signs['up'] .. '1<CR>'),
      \ }
  if a:direct ==# 'left' || a:direct ==# 'right'
    return s:keycode('<Cmd>vertical resize ' .. l:signs[a:direct] .. a:count1 .. '<CR>')
  else
    return s:keycode('<Cmd>resize ' .. l:signs[a:direct] .. a:count1 .. '<CR>')
  endif
endfunction
function! s:win_resize_cmd(direct) abort
  return get(s:win_resize_cmd_dict, a:direct, '')
endfunction
nnoremap <expr> <C-w><Down>  <SID>win_resize_count_cmd_with_update('down', v:count1)  .. '<Plug>(window-resize-mode)'
nnoremap <expr> <C-w><Up>    <SID>win_resize_count_cmd_with_update('up', v:count1)    .. '<Plug>(window-resize-mode)'
nnoremap <expr> <C-w><Right> <SID>win_resize_count_cmd_with_update('right', v:count1) .. '<Plug>(window-resize-mode)'
nnoremap <expr> <C-w><Left>  <SID>win_resize_count_cmd_with_update('left', v:count1)  .. '<Plug>(window-resize-mode)'
nnoremap <expr> <Plug>(window-resize-mode)<Down>  <SID>win_resize_cmd('down')  .. '<Plug>(window-resize-mode)'
nnoremap <expr> <Plug>(window-resize-mode)<Up>    <SID>win_resize_cmd('up')    .. '<Plug>(window-resize-mode)'
nnoremap <expr> <Plug>(window-resize-mode)<Right> <SID>win_resize_cmd('right') .. '<Plug>(window-resize-mode)'
nnoremap <expr> <Plug>(window-resize-mode)<Left>  <SID>win_resize_cmd('left')  .. '<Plug>(window-resize-mode)'

" モーション
for motion in [['i2', 'i"'], ['i8', "i'"], ['i9', 'i('], ['i0', 'i)'],
            \  ['a2', '2i"'], ['a7', "2i'"], ['a8', 'a('], ['a9', 'a)'], ['a`', '2i`']]
  execute 'onoremap ' .. motion[0] .. ' ' .. motion[1]
  execute 'xnoremap ' .. motion[0] .. ' ' .. motion[1]
endfor
for motion in ['f', 't', 'F', 'T']
  for char in [['1', '!'], ['2', '"'], ['3', '#'], ['4', '$'], ['5', '%'], ['6', '&'], ['7', "'"], ['8', "'"], ['9', '('], ['0', ')']]
    for mode in ['n', 'o', 'x']
      execute mode .. 'noremap ' .. motion .. char[0] .. ' ' .. motion .. char[1]
      execute mode .. 'noremap ' .. motion .. char[1] .. ' ' .. motion .. char[0]
    endfor
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

" Karabiner で } と { を入れ替えてるけど、移動は元のキーで。
if has("mac")
  nnoremap { }
  xnoremap { }
  nnoremap } {
  xnoremap } {
endif

" 文字コード入力
inoremap <C-v>u <C-r>=nr2char(0x)<Left>
