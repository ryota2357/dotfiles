{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];
  xdg.configFile = {
    "tmux/tmux.conf".source = ../../../tmux/tmux.conf;
    "tmux/config".source = ../../../tmux/config;
    "tmux/bin".source = ../../../tmux/bin;
  };
}
