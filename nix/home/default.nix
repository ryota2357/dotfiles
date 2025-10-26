{
  system,
  username,
  home-manager,
  pkgs,
}:
{
  default = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      config-file = import ../../config-files/_generated.nix;
    };
    modules = [
      {
        home = {
          inherit username;
          homeDirectory =
            if pkgs.stdenv.hostPlatform.isDarwin then
              "/Users/${username}"
            else
              throw "unsupported system: ${system}";
          stateVersion = "24.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        };
        programs.home-manager.enable = true;
      }
      ./modules/ai.nix
      ./modules/direnv.nix
      ./modules/fd.nix
      ./modules/git.nix
      ./modules/rg.nix
      ./modules/shell.nix
      ./modules/terminal.nix
      ./modules/texlive.nix
      ./modules/tmux.nix
      ./modules/vim.nix
      {
        home.file.".local/bin".source = ../../bin;
        home.packages = with pkgs; [
          ffmpeg
          fzf
          hyperfine
          imagemagick
          jq
          # nix-output-monitor
          (nix-output-monitor.overrideAttrs (prev: {
            patches = prev.patches or [ ] ++ [
              (fetchpatch2 {
                name = "fix-local-store-url-parsing.patch";
                url = "https://github.com/maralorn/nix-output-monitor/pull/203.patch";
                hash = "sha256-unpJ+tZO2HLVion7vvhj+Xn2wFOzwxnqMohPIFACX+Q=";
              })
            ];
          }))
          rsync
          tokei
          tree
          watchexec
          wget

          nodePackages.svgo
          pdf2svg

          # gnuplot_qt  # qt周りでエラー起こしてterm qtが使えない
          # gcc         # ccがgccになってしまうしapple clangとぶつかると怖いので

          # Language/Framework tools
          deno
          elan
          nodejs_24
          rustup
          shellcheck
          typst
          tinymist
        ];
      }
    ];
  };
}
