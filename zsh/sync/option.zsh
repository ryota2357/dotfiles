# カラー設定
# autoload -Uz colors && colors

# 言語
export LANG=ja_JP.UTF-8

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数
HISTSIZE=100000

# 履歴ファイルに保存される履歴の件数
SAVEHIST=1000000

# 改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# 履歴ファイルに開始時刻と経過時間を記録
setopt extended_history

# 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt append_history

# 重複を記録しない(古いものを削除)
setopt hist_ignore_all_dups

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# historyコマンドは記録しない
setopt hist_no_store

# スペースで始まるコマンド行は記録しない
setopt hist_ignore_space

# 余計な空白を除去して記録
setopt hist_reduce_blanks

# コマンド終了時に、履歴ファイルに書き込む
# inc_append_history_time: 実行時に履歴をファイルに追加していく
# ↑では extended_history と併用した時、経過時間が全て0で記録されることになる
setopt inc_append_history_time

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# 補完で末尾に補われた / を自動的に削除
setopt auto_remove_slash

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt list_types

# cdなしでディレクトリを移動
setopt auto_cd

# コマンドのうち間違え防止
setopt correct

# ビープ音を消す
setopt no_beep

# <C-d>でログアウトしない
setopt ignore_eof

# rm * を実行する前に一時停止
setopt rm_star_wait
