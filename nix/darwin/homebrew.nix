{
  enable = true;
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
  taps = [
    "buo/cask-upgrade"
    "ryota2357/pleck-jp"
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
    "tor-browser"

    # Text Editor
    "coteditor"
    "jetbrains-toolbox"
    "visual-studio-code"
    "obsidian"

    # Fonts
    "font-cica"
    "font-hack-nerd-font"
    "font-harano-aji"
    "font-plemol-jp-nf"
    "pleck-jp"

    # Dev Tools
    "docker-desktop"
    "dotnet-sdk"
    "fontforge-app"
    "obsidian"
    "unity-hub"

    # Social
    "discord"
    "slack"
    "zoom"

    # macOS improvements
    "alfred"
    "alt-tab"
    "hhkb"
    "hiddenbar"
    "iina"
    "karabiner-elements"
    "keycastr"
    "obs"
    "skim"

    # AI
    "chatgpt"
    "claude"

    # Game
    "osu"
  ];
}
