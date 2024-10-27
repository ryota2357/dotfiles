local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- IME
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

-- Appearance
config.font = wezterm.font("PleckJP")
config.font_size = 18.5
config.enable_tab_bar = false
config.colors = {
    cursor_bg = "#fffaf5",
    cursor_fg = "black",
    cursor_border = "#fffaf5",
}
-- config.window_decorations = 'NONE'

-- Key
config.keys = {
    { key = "¥", action = wezterm.action.SendString("\\") },
    { key = "¥", mods = "ALT", action = wezterm.action.SendString("¥") },
    { key = "+", mods = "CMD", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "CMD", action = wezterm.action.DecreaseFontSize },
    { key = "0", mods = "CMD", action = wezterm.action.ResetFontSize },
}
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CMD",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

-- Startup
config.native_macos_fullscreen_mode = true
wezterm.on("gui-startup", function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
end)
config.default_prog = {
    "/bin/bash",
    "-c",
    [=[
    tmux_connect="$HOME/.local/bin/tmux-connect"
    tmux_paths="$HOME/.nix-profile/bin/tmux"
    if [[ -x "$tmux_connect" ]]; then
      "$tmux_connect" --paths "$tmux_paths"
    else
      echo "Command not found: $tmux_connect"
      /bin/zsh
    fi
    ]=],
}

return config
