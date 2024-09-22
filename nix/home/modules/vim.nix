{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    neovim
    tree-sitter
  ];
  xdg.configFile =
    let
      s = name: { source = ../../../vim + "/${name}"; };
    in
    {
      # entry files
      "vim/vimrc" = s "vimrc";
      "nvim/init.lua" = s "init.lua";
      "ideavim/ideavimrc" = s "ideavimrc";

      # neovim directories
      "nvim/after" = s "after";
      "nvim/denops" = s "denops";
      "nvim/lua" = s "lua";
    };

  # TODO: vscode の設定したら、XDG_CONFIG_HOME に移動する
  # home.file.".vscode".source = ../../../vim/vsvimrc;
}
