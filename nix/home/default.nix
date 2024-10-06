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
      ./modules/terminal.nix
      ./modules/texlive.nix
      ./modules/tmux.nix
      ./modules/vim.nix
      ./modules/zsh.nix
      {
        home.packages = with pkgs; [
          bat
          fastfetch
          ffmpeg
          fzf
          hyperfine
          jq
          tokei
          tree
          wget
          # yt-dlp

          nodePackages.svgo
          pdf2svg

          # gnuplot_qt   qt周りでエラー起こしてterm qtが使えない
          # gcc   # ccがgccになってしまうしapple clangとぶつかると怖いので

          # Language/Framework tools
          deno
          go
          nodejs_22
          rustup
          typst
        ];
      }
    ];
  };
}
