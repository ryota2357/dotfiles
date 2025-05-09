{
  enable = true;
  onActivation = {
    autoUpdate = true;
    # dangerous option!!!
    # cleanup = "uninstall";
  };
  taps = [
    "buo/cask-upgrade"
  ];
  brews = [
    "gawk"
    "gnu-sed"
    "llvm"
    "lld"
    "gnuplot"
    "pinentry-mac"
  ];
  casks = [
    # Terminal
    "alacritty"
    "iterm2"
    "wezterm"
    "ghostty"
    "xquartz"

    # Browser
    "arc"
    "brave-browser"
    "firefox"
    "google-chrome"
    "microsoft-edge"

    # Text Editor
    "coteditor"
    "cursor"
    "jetbrains-toolbox"
    "visual-studio-code"
    "obsidian"

    # Dev Tools
    "docker"
    "dotnet-sdk"
    "fontforge"
    "github"
    "obsidian"
    "wireshark"

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
