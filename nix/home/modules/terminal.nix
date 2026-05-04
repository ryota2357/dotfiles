{
  home.packages = [
    # installed via Homebrew
    # - alacritty
    # - wezterm
    # - ghostty
  ];
  xdg.configFile = {
    "alacritty/alacritty.toml".source = ../../../terminal/alacritty.toml;
    "wezterm/wezterm.lua".source = ../../../terminal/wezterm.lua;
    "ghostty/config".source = ../../../terminal/ghostty.ini;
  };
}
