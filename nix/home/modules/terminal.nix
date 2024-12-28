{ config-file, ... }:
{
  home.packages = [
    # install with homebrew
  ];
  xdg.configFile = {
    "alacritty/alacritty.toml".source = config-file."alacritty.toml";
    "wezterm/wezterm.lua".source = config-file."wezterm.lua";
    "ghostty/config".source = config-file."ghostty~config";
  };
}
