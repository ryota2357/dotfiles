{
  system,
  username,
  home-manager,
  pkgs,
}:
let
  isDarwin = builtins.elem system [
    "aarch64-darwin"
    "x86_64-darwin"
  ];
in
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
          homeDirectory = if isDarwin then "/Users/${username}" else throw "unsupported system: ${system}";
          stateVersion = "24.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        };
      }
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
          jq
          rsync
          tokei
          tree
          watchexec
          wget
          # yt-dlp

          nodePackages.svgo
          pdf2svg

          # gnuplot_qt   qt周りでエラー起こしてterm qtが使えない
          # gcc   # ccがgccになってしまうしapple clangとぶつかると怖いので

          # Language/Framework tools
          deno
          elan
          go
          nodejs_23
          rustup
          shellcheck
          typst
        ];
      }
    ];
  };
}
