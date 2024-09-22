{
  system,
  nix-darwin,
}:
{
  default = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      (
        { pkgs, ... }:
        {
          nix = {
            optimise.automatic = true;
            settings = {
              experimental-features = "nix-command flakes";
              max-jobs = 8;
            };
          };
          services.nix-daemon.enable = true;
          system = import ./system.nix;
          homebrew = import ./homebrew.nix;
        }
      )
    ];
  };
}
