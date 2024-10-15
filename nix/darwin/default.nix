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
            gc = {
              automatic = true;
              interval = {
                Hour = 9;
                Minute = 0;
              };
              options = "--delete-older-than 10d";
            };
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
