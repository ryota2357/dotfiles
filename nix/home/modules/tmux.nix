{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];
  xdg.configFile =
    let
      s = name: { source = ../../../tmux + "/${name}"; };
    in
    {
      "tmux/tmux.conf" = s "tmux.conf";
      "tmux/config" = s "config";
    };
}
