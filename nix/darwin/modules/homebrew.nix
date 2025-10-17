{
  homebrew = {
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
      "docker-completion"
      "gawk"
      "gcc"
      "gnu-sed"
      "gnuplot"
      "lld"
      "llvm"
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
      "drawio"
      "fontforge-app"
      "obsidian"
      "unity-hub"
      "racket" # nixのはminimal版しかdarwinに対応していない

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
      "logi-options+"
      "obs"
      "skim"

      # AI
      "chatgpt"
      "claude"

      # Game
      "osu"
    ];
  };
}
