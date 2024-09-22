{ nixpkgs }:
builtins.foldl'
  (
    acc: system:
    acc
    // {
      ${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    }
  )
  { }
  [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ]
