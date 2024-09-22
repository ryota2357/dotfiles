{ pkgs, config-file, ... }:
{
  home.packages = [ pkgs.texliveFull ];
  xdg.configFile."latexmk/latexmkrc".source = config-file."latexmkrc";
}
