# マウスを有効化
set-option -g mouse on

# 履歴を長く(バックスクロール行数)
set-option -g history-limit 100000

# ウィンドウとペインの番号を 1 から開始
set-option -g base-index 1
set-option -g pane-base-index 1

# ウィンドウの番号を詰める
set-option -g renumber-windows on

# ESC の遅延を 0 に
set -s escape-time 0

# vim とかの focus イベントが発火するように
set-option -g focus-events on

# セッション間での自動的なリサイズを有効化
set-option -g aggressive-resize on

# tmux起動時のシェル
set-option -g default-shell "$HOME/.nix-profile/bin/fish"
# set-option -g default-shell "/bin/zsh"
# set-option -g default-shell "$HOMEBREW_PREFIX/bin/zsh"

# 256色、TrueColor, Undercurl の対応
set-option -g default-terminal "tmux-256color"
set -as terminal-features ",*:RGB"
set -as terminal-features ",*:usstyle"

# 拡張キーシーケンスを有効にする
set -s extended-keys on
