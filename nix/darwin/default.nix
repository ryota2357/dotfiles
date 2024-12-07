{
  system,
  nix-darwin,
}:
{
  default = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      {
        services.nix-daemon.enable = true;
        nix = import ./nix.nix;
        system = import ./system.nix;
        homebrew = import ./homebrew.nix;
      }
    ];
  };
}
