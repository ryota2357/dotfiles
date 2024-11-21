{ nixpkgs }:
nixpkgs.lib.genAttrs [
  "aarch64-linux"
  "aarch64-darwin"
  "x86_64-darwin"
  "x86_64-linux"
] (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style)
