local wezterm = require('wezterm');
local config = wezterm.config_builder()

config.font = wezterm.font('PleckJP')
config.font_size = 18.5

config.use_ime = true
config.enable_tab_bar = false

config.colors = {
    cursor_bg = '#fffaf5',
    cursor_fg = 'black',
    cursor_border = '#fffaf5',
}

config.keys = {
    { key = '+', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
    { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

config.default_prog = {
    '/bin/zsh',
    '--login',
    '-c',
    [=[
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
      tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | $PERCOL | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
      tmux new-session
    fi
    tmux attach-session -t "$ID"
    ]=]
}

return config
