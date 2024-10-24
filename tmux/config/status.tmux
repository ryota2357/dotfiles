# ステータスバーをトップに配置する
set-option -g status-position top

# 更新間隔を 1 秒に
set-option -g status-interval 1

# 背景色
set-option -g status-bg "#494949"

# 文字色
set-option -g status-fg "#ffffff"

# command prompt (prefix + :) では emacs キーバインドを使う
set-option -g status-keys emacs

# === window-status ===
# 中央よせ
set-option -g status-justify "centre"
# window-status のフォーマットを指定
set-window-option -g window-status-format " #I: #W "
# カレントウィンドウの window-status のフォーマットを指定
set-window-option -g window-status-current-format "#[bg="#0069c0",bold] #I: #W #[default]"

# == 左 ==
# 最大の長さ
set-option -g status-left-length 20
# フォーマット
set-option -g status-left "#[bg="#707070"]   #S #[default]"


# == 右 ==
# 最大の長さ
set-option -g status-right-length 100
# フォーマット
set-option -g status-right "#[bg="#707070"]   #h   #{online_status}  #{battery_icon} #{battery_color_fg}#{battery_percentage}#[fg="#ffffff" bg="#707070"]    %m/%d %H:%M:%S #[default]"

set -g @online_icon "#[fg="#80e27e"] #[fg="#ffffff"]"
set -g @offline_icon "#[fg="#ff6f60"] #[fg="#ffffff"]"

set -g @batt_color_charge_primary_tier8 "#4caf50" # [95%-100%]
set -g @batt_color_charge_primary_tier7 "#80e27e" # [80%-95%)
set -g @batt_color_charge_primary_tier6 "#80e27e" # [65%-80%)
set -g @batt_color_charge_primary_tier5 "#bef67a" # [50%-65%)
set -g @batt_color_charge_primary_tier4 "#bef67a" # [35%-50%)
set -g @batt_color_charge_primary_tier3 "#ffeb3b" # [20%-35%)
set -g @batt_color_charge_primary_tier2 "#ffeb3b" # (5%-20%)
set -g @batt_color_charge_primary_tier1 "#ff0000" # [0%-5%]
set -g @batt_color_charge_secondary_tier8 "#707070"
set -g @batt_color_charge_secondary_tier7 "#707070"
set -g @batt_color_charge_secondary_tier6 "#707070"
set -g @batt_color_charge_secondary_tier5 "#707070"
set -g @batt_color_charge_secondary_tier4 "#707070"
set -g @batt_color_charge_secondary_tier3 "#707070"
set -g @batt_color_charge_secondary_tier2 "#707070"
set -g @batt_color_charge_secondary_tier1 "#707070"

set -g @batt_color_status_primary_charging "#5ddef4"
set -g @batt_color_status_secondary_charging "#707070"
set -g @batt_color_status_primary_charged "#039be5"
set -g @batt_color_status_secondary_charged "#707070"

set -g @batt_icon_charge_tier8 "󰁹" # [95%-100%]
set -g @batt_icon_charge_tier7 "󰂂" # [80%-95%)
set -g @batt_icon_charge_tier6 "󰂀" # [65%-80%)
set -g @batt_icon_charge_tier5 "󰁿" # [50%-65%)
set -g @batt_icon_charge_tier4 "󰁽" # [35%-50%)
set -g @batt_icon_charge_tier3 "󰁼" # [20%-35%)
set -g @batt_icon_charge_tier2 "󰁻" # (5%-20%)
set -g @batt_icon_charge_tier1 "󰂎" # [0%-5%]
set -g @batt_icon_status_charging "󰂄"
set -g @batt_icon_status_charged "󰂄"
