{ pkgs, config-file, ... }:
{
  home.packages = with pkgs; [
    git
    git-lfs
    gh
    ghq
    lazygit
    gnupg
  ];
  xdg.configFile."git/ignore".source = config-file."git~ignore";
}
