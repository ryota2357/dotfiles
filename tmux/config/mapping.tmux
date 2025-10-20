# prefixキーをC-sに変更
set-option -g prefix C-s
unbind-key C-b

# c: 新規ウィンドウ作成
bind-key c new-window -c '#{pane_current_path}'

# prefix と : の同時押しでも prefix + : と同じく command prompt を開く
bind-key "'" command-prompt

# v, s: ペインを分割
bind-key v split-window -h -c '#{pane_current_path}'
bind-key s split-window -v -c '#{pane_current_path}'

# `C-w` で WINDOW table に切り替え (https://qiita.com/izumin5210/items/d2e352de1e541ff97079)
bind-key -n C-w switch-client -T WINDOW

# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

# `C-w` + h, j, k, l: ウィンドウ間を移動
# `C-w` + <arrow>: ペインのリサイズ
bind-key -T WINDOW h if-shell "$is_vim" "send-keys C-w h" "select-pane -L"
bind-key -T WINDOW j if-shell "$is_vim" "send-keys C-w j" "select-pane -D"
bind-key -T WINDOW k if-shell "$is_vim" "send-keys C-w k" "select-pane -U"
bind-key -T WINDOW l if-shell "$is_vim" "send-keys C-w l" "select-pane -R"
bind-key -T WINDOW -r Left  if-shell "$is_vim" "send-keys C-w Left"  "resize-pane -L 1"
bind-key -T WINDOW -r Down  if-shell "$is_vim" "send-keys C-w Down"  "resize-pane -D 1"
bind-key -T WINDOW -r Up    if-shell "$is_vim" "send-keys C-w Up  "  "resize-pane -U 1"
bind-key -T WINDOW -r Right if-shell "$is_vim" "send-keys C-w Right" "resize-pane -R 1"

# `C-w` が tmux に喰われてしまうので，2回打つことで Vim に `C-w` を送れるようにして救う
# 使用頻度の高い Window command がある場合は，明示的に `bind -T WINDOW <key> send-keys C-w <key>` すればいい
bind-key -T WINDOW C-w send-keys C-w

# q: ペインを閉じる
bind-key q kill-pane

# y: コピーモードを開始
bind-key y copy-mode

# コピーモードでvimキーバインドを使う
set-window-option -g mode-keys vi

# v: 選択開始
# y: ヤンク
# i: ノーマルモードに戻る
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-pipe "reattach-to-user-namespace pbcopy" \; send -X clear-selection
bind-key -T copy-mode-vi i send-keys -X cancel

# V: 行選択
# Y: 行ヤンク
bind-key -T copy-mode-vi V send-keys -X select-line
bind-key -T copy-mode-vi Y send-keys -X copy-line

# g: lazygit を popup window で起動
bind-key g popup -d "#{pane_current_path}" -w 95% -h 97% -y P -b rounded -E "lazygit"
