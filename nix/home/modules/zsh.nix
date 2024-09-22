{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    # zsh   # システムのを使う
    sheldon
  ];
  # TODO: nix との連携ができる nix に依存しない plugin manager 自作する
  home.file =
    builtins.foldl'
      (
        acc: fname:
        acc
        // {
          ".${fname}" = {
            source = ../../../zsh + "/${fname}";
            # home.file.<name> で生成されるファイルの Modified は 0 になる。
            # 自動 zcompile がかかるようにするため、*.zwc を消す。
            onChange = "rm -f ${config.home.homeDirectory + "/.${fname}"}.zwc";
          };
        }
      )
      { }
      [
        "zshrc"
        "zprofile"
        "zshenv"
      ];
  xdg.configFile =
    let
      s = name: { source = ../../../zsh + "/${name}"; };
    in
    {
      "sheldon/plugins.toml" = s "plugins.toml";
    };
}
