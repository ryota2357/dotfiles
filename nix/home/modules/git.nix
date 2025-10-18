{ pkgs, config-file, ... }:
{
  home.packages = with pkgs; [
    git
    git-lfs
    gh
    ghq
    lazygit
    gnupg
    delta
  ];
  xdg.configFile = {
    "git/ignore".source = config-file."git~ignore";
    "git/config".source = config-file."git~config";
    "lazygit/config.yml".source = config-file."lazygit~config.yaml";
  };
}
