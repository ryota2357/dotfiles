{ pkgs, ... }:
let
  s = name: { source = ../../../shell + "/${name}"; };
in
{
  home.packages = with pkgs; [
    bash
    # zsh   # システムのを使う
    fish
  ];
  home.file = {
    ".zshenv" = s "zsh/zshenv";
    ".zshrc" = s "zsh/zshrc";
  };
  xdg.configFile = {
    "zsh/alias.zsh" = s "zsh/alias.zsh";
    "zsh/completion.zsh" = s "zsh/completion.zsh";
    "zsh/option.zsh" = s "zsh/option.zsh";
    "zsh/prompt.zsh" = s "zsh/prompt.zsh";

    "fish/config.fish" = s "fish/config.fish";
    "fish/conf.d" = s "fish/conf.d";
    "fish/prompt.fish" = s "fish/prompt.fish";
    "fish/shortcut.fish" = s "fish/shortcut.fish";
  };
}
