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
      neovim-nightly-overlay,
    }:
    let
      system = "aarch64-darwin";
    in
    {
      apps = (
        import ./nix/apps/default.nix {
          inherit nixpkgs;
        }
      );

      formatter = (
        import ./nix/formatter/default.nix {
          inherit nixpkgs;
        }
      );

      darwinConfigurations = (
        import ./nix/darwin/default.nix {
          inherit system nix-darwin;
        }
      );

      homeConfigurations = (
        import ./nix/home/default.nix {
          inherit system home-manager;
          username = "ryota2357";
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              neovim-nightly-overlay.overlays.default
            ];
          };
        }
      );
    };
}
