{ nixpkgs, treefmt-nix }:
nixpkgs.lib.genAttrs
  [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ]
  (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    treefmt-nix.lib.mkWrapper pkgs {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        stylua.enable = true;
        taplo.enable = true;
        yamlfmt.enable = true;
      };
      settings.global.excludes = [
        ".envrc"
        "vim/**/*.vim"
        "shell/*"
        "ahk/*"
        "tmux/*"
      ];
    }
  )
