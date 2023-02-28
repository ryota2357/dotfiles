#!/bin/sh

# undercurl 対応の termcolor を作成
# 参考: https://dev.to/jibundit/undercurl-display-on-neovim-and-tmux-with-iterm2-3pi0
# tic: terminfo 記述ファイルをコンパイル済みのフォーマットに変換
#    -x: 未知の capabilities をユーザー定義のものして扱い、テーブルエントリを拡張する
tic -x "$HOME/dotfiles/terminfo/screen-256color.ti"
tic -x "$HOME/dotfiles/terminfo/xterm-256color.ti"
tic -x "$HOME/dotfiles/terminfo/tmux-256color.ti"
