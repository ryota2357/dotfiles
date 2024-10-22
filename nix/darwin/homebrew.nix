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
    "jetbrains-toolbox"

    # Dev Tools
    "docker"
    "dotnet-sdk"
    "fontforge"
    "github"

    # Social
    "discord"
    "slack"
    "zoom"

    # macOS improvements
    "alfred"
    "alt-tab"
    "hiddenbar"
    "iina"
    "karabiner-elements"
    "keycastr"
    "obs"
    "skim"

    # Game
    "osu"
  ];
}
