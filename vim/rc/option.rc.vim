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
set history=1000

" 行番号表示
set number

" 現在行のハイライトを有効
set cursorline

" ステータスラインは常に1つ
set laststatus=3

" モードのメッセージをコマンドラインに表示しない
set noshowmode

" 左の余白(目印桁)を常に表示
set signcolumn=yes:1

" マウスを有効に
set mouse=a

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
" extends: tabキーを押すとスペースが入力される
" tabstop: 画面上で表示する1つのタブの幅
" softtabstop: いくつの連続した空白を1回で削除できるようにするか
" shiftwidth; 自動インデントでのインデントの長さ
" autoindent: 改行した時に自動でインデントします
" smartindent: {があると次の行は自動で1段深く自動インデントしてくれる
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

" 検索パターンにおいて大文字と小文字を区別しない
set ignorecase

" マーカー位置で折りたたむ
set foldmethod=marker

" 必要ない標準プラグインの読み込みを停止
" man: vimでmanをみる
" matchit: %でカッコ対応ペアの移動強化
" netrw*: 標準ファイラ
" turot*: :Tutor
" vimball: :h vimball、プラグインを使いやすくするプラグイン?
" gzip: zipファイルを開いた時に展開せずにVimでアーカイブ内のファイルを閲覧・編集できる
" zipPlugin: ↑と同じ?
let g:loaded_man = v:true
let g:loaded_matchit = v:true
let g:loaded_netrwPlugin = v:true
let g:loaded_netrwFileHandlers = v:true
let g:loaded_netrwSettings = v:true
let g:loaded_tutor_mode_plugin = v:true
let g:loaded_vimballPlugin = v:true
let g:loaded_gzip = v:true
let g:loaded_zipPlugin = v:true
