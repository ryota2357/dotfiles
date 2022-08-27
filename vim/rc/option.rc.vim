" エンコーディング
set encoding=utf8
scriptencoding utf8
set fileencodings=utf-8,ucs-boms,euc-jp,ep932
set fileformat=unix
set fileformats=unix,dos,mac

" 曖昧文字幅の幅を指定するもの
" doubleにすると、文字崩れ、文字残りが起こる
" iTerm2の設定でも `Ambiguous characters width are double-width` という項目があるけど有効にすると表示される文字が消えたりする
set ambiwidth=single

" BOMを消す
" BOM(byte order mark): Unicodeの符号化形式で符号化したテキストの先頭につける数バイトのデータのことで、このデータを元にUnicodeで符号化されていることと符号化の種類を判別する
set nobomb

" shellをzshに
set shell=/bin/zsh

" 編集中のファイルが他で書き換えられたら自動で読み直す
set autoread

" ファイルの変更チェックの頻度を強化 (https://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html)
augroup autoreadChecktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" ヤンクをクリップボードへ繋ぐ
set clipboard+=unnamed

" ビープ音を消す
set belloff=all

" スワップファイルを生成しない
set noswapfile

" true color
" 対応できているかの確認は
"  curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash
" を実行(https://www.pandanoir.info/entry/2019/11/02/202146)
set termguicolors

" 保存するコマンド履歴の数
set history=100

" 行番号表示
set number

" 現在行のハイライトを有効
set cursorline

" ステータスラインは常に1つ
set laststatus=3

" マウスを有効に
set mouse=a

" Vimにフォーカスを戻した時だけマウスを無効に
augroup Mouse
  autocmd!
  autocmd FocusGained * call s:OnFocusGained()
  autocmd FocusLost * call s:OnFocusLost()
augroup END

function! s:OnFocusGained() abort
  autocmd CursorMoved,CursorMovedI,ModeChanged,WinScrolled * ++once call s:EnebleLeftMouse()
  noremap  <LeftMouse> <Cmd>call <SID>EnebleLeftMouse()<CR>
  inoremap <LeftMouse> <Cmd>call <SID>EnebleLeftMouse()<CR>
endfunction

function! s:EnebleLeftMouse() abort
  silent! unmap <LeftMouse>
  silent! iunmap <LeftMouse>
endfunction

function! s:OnFocusLost() abort
  noremap  <LeftMouse> <nop>
  inoremap <LeftMouse> <nop>
endfunction

" 行末の1文字先までカーソルを移動可能に
set virtualedit=onemore

" カーソル移動の行等行末の扱い
set whichwrap=b,s,<,>,~,[,]

" インサートモードでの<BS>, <Del>の扱い
set backspace=indent,eol,start

" どこでも短形ビジュアルモード
set virtualedit=block

" menuone: 候補が1つしかない時もポップアップメニューを出す
" noinsert: 候補の1つ目を選択してある状態になる(理由わかってない)
set completeopt=menuone,noinsert

" 行の折り返しを無効に
set nowrap

" 画面の左右の端でスクロールが発生した場合、何文字ずつスクロールするか
set sidescroll=1

" 表示文字設定
"   extends:  行が画面よりも伸びているときの最終列に表示
"   precedes: 行が画面よりも伸びているときの最初の列に表示
"   space:    空白の表示
set list
set listchars=extends:>,precedes:<,space:⋅

" 全角カッコペアの追加
set matchpairs+=（:）,「:」,『:』,【:】,［:］,＜:＞

" スクロールの余裕
set scrolloff=3
set sidescrolloff=5

" インデント設定
set expandtab     " tabキーを押すとスペースが入力される
set tabstop=4     " 画面上で表示する1つのタブの幅
set softtabstop=4 " いくつの連続した空白を1回で削除できるようにするか
set shiftwidth=4  " 自動インデントでのインデントの長さ
set autoindent    " 改行した時に自動でインデントします
set smartindent   " {があると次の行は自動で1段深く自動インデントしてくれる

" 検索パターンにおいて大文字と小文字を区別しない
set ignorecase

" マーカー位置で折りたたむ
set foldmethod=marker
