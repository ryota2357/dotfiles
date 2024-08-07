{
  description = "ryota2357's HOME environment for mac";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, neovim-nightly-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
            inherit system;
            overlays = [ neovim-nightly-overlay.overlays.default ];
        };
      in {
        packages.home = pkgs.buildEnv {
          name = "home";
          paths = with pkgs; [
            bat
            cloc
            fastfetch
            ffmpeg
            fzf
            gh
            git
            gnupg
            # gnuplot_qt   qt周りでエラー起こしてterm qtが使えない
            hyperfine
            jq
            lazygit
            neovim
            nodePackages.svgo
            pdf2svg
            ripgrep
            tmux
            tree
            tree-sitter
            vim
            wget
            # yt-dlp

            # Language/Framework tools
            act
            cmake
            dart
            deno
            # gcc   # ccがgccになってしまうしapple clangとぶつかると怖いので
            go
            jdk
            ninja
            php
            rye
            # rbenv
            rustup
            texliveFull
            typst
            volta
            wabt
          ];
        };
        apps.update = {
          type = "app";
          program = toString (pkgs.writeShellScript "update-script" ''
            set -e
            echo "Updating flake..."
            nix flake update
            echo "Updating profile..."
            nix profile upgrade home
            echo "Update complete!"
          '');
        };
      }
    );
}
