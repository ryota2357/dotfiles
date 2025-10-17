{
  system,
  nix-darwin,
}:
{
  default = nix-darwin.lib.darwinSystem {
    inherit system;
    modules = [
      ./modules/nix.nix
      ./modules/system.nix
      ./modules/homebrew.nix
    ];
  };
}
