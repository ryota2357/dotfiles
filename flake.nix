{
  description = "ryota2357's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      treefmt-nix,
      neovim-nightly-overlay,
    }:
    let
      system = "aarch64-darwin";
    in
    {
      apps = (
        import ./nix/apps {
          inherit nixpkgs;
        }
      );

      formatter = (
        import ./nix/formatter {
          inherit nixpkgs treefmt-nix;
        }
      );

      darwinConfigurations = (
        import ./nix/darwin {
          inherit system nix-darwin;
        }
      );

      homeConfigurations = (
        import ./nix/home {
          inherit system home-manager;
          username = "ryota2357";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              neovim-nightly-overlay.overlays.default
            ];
          };
        }
      );

      devShells.${system}.default =
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShellNoCC {
          packages = with pkgs; [
            lua-language-server
            vim-language-server
            nil
          ];
        };
    };
}
