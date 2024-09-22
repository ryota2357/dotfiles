{ pkgs, config-file, ... }:
{
  home.packages = with pkgs; [
    git
    gh
    lazygit
    gnupg
  ];
  xdg.configFile."git/ignore".source = config-file."git~ignore";
}
