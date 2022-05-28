# カラー設定
autoload -Uz colors && colors

# 言語
export LANG=ja_JP.UTF-8

# 履歴ファイルの保存先
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数
HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数
SAVEHIST=100000

# 重複を記録しない(古いものを削除)
setopt hist_ignore_all_dups

# historyコマンドは記録しない
setopt hist_no_store

# スペースで始まるコマンド行は記録しない
setopt hist_ignore_space

# 余計な空白を除去して記録
setopt hist_reduce_blanks

# 実行時に履歴をファイルにに追加していく
setopt inc_append_history


# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# cdなしでディレクトリを移動
setopt auto_cd

# コマンドのうち間違え防止
setopt correct
