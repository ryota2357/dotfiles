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
  xdg.configFile = builtins.foldl' (acc: name: acc // { ${name} = s name; }) { } [
    "zsh/alias.zsh"
    "zsh/completion.zsh"
    "zsh/option.zsh"
    "zsh/prompt.zsh"

    "fish/config.fish"
    "fish/conf.d"
    "fish/completions"
    "fish/functions"
    "fish/prompt.fish"
    "fish/shortcut.fish"
  ];
}
