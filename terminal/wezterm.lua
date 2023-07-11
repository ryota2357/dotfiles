local wezterm = require('wezterm');
local config = wezterm.config_builder()

-- IME
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL'

-- Appearance
config.font = wezterm.font('PleckJP')
config.font_size = 18.5
config.enable_tab_bar = false
config.colors = {
    cursor_bg = '#fffaf5',
    cursor_fg = 'black',
    cursor_border = '#fffaf5',
}
-- config.window_decorations = 'NONE'

-- Key
config.keys = {
    { key = '¥',               action = wezterm.action.SendString('\\') },
    { key = '¥', mods = 'ALT', action = wezterm.action.SendString('¥')  },
    { key = '+', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
    { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize    },
}
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- Startup
config.native_macos_fullscreen_mode = true
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)
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
