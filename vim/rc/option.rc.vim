" エンコーディング
set encoding=utf8
scriptencoding utf8
set fileencodings=utf-8,ucs-boms,euc-jp,ep932
set fileformat=unix
set fileformats=unix,dos,mac

" 曖昧文字幅の幅を指定するもの
" doubleにすると、文字崩れ、文字残りが起こる
" iTerm2の設定でも Ambiguous characters width are double-width
" という項目があるけど有効にすると表示される文字が消えたりする
set ambiwidth=single

" よくわからないけどBOMを消すものらしい
" BOMは特に何かなければ無い方が良いみたい
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

" マウスを有効に
set mouse=a

" 行末の1文字先までカーソルを移動可能に
set virtualedit=onemore

" カーソル移動の行等行末の扱い
set whichwrap=b,s,<,>,~,[,]

" 行の折り返しを無効に (warpは遅いらしい)
set nowrap

" 画面の左右の端でスクロールが発生した場合、何文字ずつスクロールするか
set sidescroll=1

" 行が画面よりも伸びているときに最終列、最初の列に表示する文字
set listchars=extends:>,precedes:<

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

" ファイル別インデント設定オーバーライド
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.dart setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" 検索パターンにおいて大文字と小文字を区別しない
set ignorecase

" マーカー位置で折りたたむ
set foldmethod=marker
