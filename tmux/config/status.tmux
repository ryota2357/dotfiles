# ステータスラインをトップに配置する
set-option -g status-position top

# 定期更新をしない
set-option -g status-interval 0

# 背景色
set-option -g status-bg "#494949"

# 文字色
set-option -g status-fg "#ffffff"

# command prompt (prefix + :) では emacs キーバインドを使う
set-option -g status-keys emacs

# === window-status ===
# 中央よせ
set-option -g status-justify "absolute-centre"
# window-status のフォーマットを指定
set-window-option -g window-status-format " #I: #W "
# カレントウィンドウの window-status のフォーマットを指定
set-window-option -g window-status-current-format "#[fg=#0069c0,bg=#494949]#[bg=#0069c0,fg=#ffffff,bold]#I: #W#[fg=#0069c0,bg=#494949]"

# == 左 ==
# 最大の長さ
set-option -g status-left-length 20
# フォーマット
set-option -g status-left "#[fg=#707070,bg=#494949]#[bg=#707070,fg=#ffffff]   #S #[fg=#707070,bg=#494949]"

# == 右 ==
# 最大の長さ
set-option -g status-right-length 50
# フォーマット
set-option -g status-right "#[fg=#707070,bg=#494949]#[bg=#707070,fg=#ffffff] #("$HOME/.config/tmux/bin/git_status.sh" '#{pane_current_path}') #[fg=#707070,bg=#494949]"
