{ pkgs, config-file, ... }:
{
  home.packages = with pkgs; [
    sketchybar
    vm_stat2
    # installed via Homebrew
    # - aerospace
  ];
  xdg.configFile = {
    "aerospace/aerospace.toml".source = config-file."aerospace.toml";
    "sketchybar/sketchybarrc".source = ../../../sketchybar/sketchybarrc;
    "sketchybar/plugins".source = ../../../sketchybar/plugins;
  };
}
