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
set-option -sg escape-time 0

# vim とかの focus イベントが発火するように
set-option -g focus-events on

# セッション間での自動的なリサイズを有効化
set-window-option -g aggressive-resize on

# tmux起動時のシェルをhomebrewのzshにする
# brew の zsh 使うと _arguments:comparguments:409: not enough arguments
# って出るからひとまず標準の zsh 使う
# set-option -g default-shell "$HOMEBREW_PREFIX/bin/zsh"
set-option -g default-shell "/bin/zsh"

# 256色対応
set-option -g default-terminal "tmux-256color"
set-option -ga terminal-overrides ",$TERM:Tc"

# ↓はよくわかってない。これがないとtmuxで下線に色がつかなくなる。
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

# undercurl 対応 (できてないのだが。。。はて)
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'

# :git で lazygit を popup window で実行
set -g command-alias[1] 'git=popup -d "#{pane_current_path}" -w 95% -h 97% -y P -b rounded -E "/bin/zsh -ic lazygit"'
