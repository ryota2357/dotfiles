{ pkgs, ... }:
let
  zcompiled =
    zfile:
    pkgs.runCommand "${builtins.baseNameOf zfile}.zwc"
      {
        src = zfile;
        nativeBuildInputs = [ pkgs.zsh ];
      }
      ''
        cp "$src" target.zsh
        zsh -c "zcompile target.zsh"
        mv target.zsh.zwc $out
      '';
in
{
  home.packages = with pkgs; [
    bash
    zsh
    fish
  ];

  home.file = {
    ".zshenv".source = ../../../shell/zsh/zshenv;
    ".zshenv.zwc".source = zcompiled ../../../shell/zsh/zshenv;
    ".zshrc".source = ../../../shell/zsh/zshrc;
    ".zshrc.zwc".source = zcompiled ../../../shell/zsh/zshrc;
  };

  xdg.configFile =
    let
      sourceZshFiles =
        names:
        let
          sourceZshFile = name: {
            ${"zsh/" + name}.source = ../../../shell/zsh + "/${name}";
            ${"zsh/" + name + ".zwc"}.source = zcompiled (../../../shell/zsh + "/${name}");
          };
        in
        builtins.foldl' (acc: name: acc // sourceZshFile name) { } names;
      sourceFishFiles =
        names:
        let
          sourceFishFile = name: {
            ${"fish/" + name}.source = ../../../shell/fish + "/${name}";
          };
        in
        builtins.foldl' (acc: name: acc // sourceFishFile name) { } names;
    in
    sourceZshFiles [
      "alias.zsh"
      "completion.zsh"
      "functions.zsh"
      "option.zsh"
      "prompt.zsh"
    ]
    // sourceFishFiles [
      "conf.d"
      "completions"
      "functions"
      "config.fish"
      "prompt.fish"
      "shortcut.fish"
    ];
}
