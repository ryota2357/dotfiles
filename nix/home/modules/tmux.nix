{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];
  xdg.configFile."tmux/tmux.conf" = {
    source = ../../../tmux/tmux.conf;
  };
}
