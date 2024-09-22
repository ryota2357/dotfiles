{ pkgs, ... }:
{
  home.packages = with pkgs; [
    direnv
    nix-direnv
  ];
  xdg.configFile."direnv/lib/nix-direnv~direnvrc" = {
    source = "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
  };
}
