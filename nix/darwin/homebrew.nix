{
  enable = true;
  onActivation = {
    autoUpdate = true;
    # dangerous option!!!
    # cleanup = "uninstall";
  };
  taps = [
    "homebrew/bundle"
    "buo/cask-upgrade"
  ];
  brews = [
    "gawk"
    "gnu-sed"
    "llvm"
    "gnuplot"
    "pinentry-mac"
  ];
  casks = [
    # Terminal
    "alacritty"
    "iterm2"
    "wezterm"
    "xquartz"

    # Browser
    "arc"
    "brave-browser"
    "firefox"
    "google-chrome"
    "microsoft-edge"

    # Text Editor
    "coteditor"
    "visual-studio-code"

    # Dev Tools
    "docker"
    "dotnet-sdk"
    "fontforge"

    # Social
    "discord"
    "slack"
    "zoom"

    # macOS improvements
    "alfred"
    "alt-tab"
    "hiddenbar"
    "karabiner-elements"
    "skim"
    "iina"
    "obs"

    # Game
    "osu"
  ];
}
