{ pkgs, ... }:
{
  home.packages = with pkgs; [
    direnv
    nix-direnv
  ];
  xdg.configFile."direnv/lib/nix-direnv~direnvrc.sh" = {
    source = "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
  };
}
