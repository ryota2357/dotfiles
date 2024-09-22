{ pkgs, config-file, ... }:
{
  home.packages = [ pkgs.fd ];
  xdg.configFile."fd/ignore".source = config-file."fd~ignore";
}
