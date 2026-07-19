{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    brews = [
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
      "brave-browser"
      "firefox"
      "google-chrome"
      "tor-browser"

      # Text Editor
      "coteditor"
      "jetbrains-toolbox"
      "obsidian"

      # Fonts
      "font-cica"
      "font-hack-nerd-font"
      "font-harano-aji"
      "font-inconsolata"
      "font-plemol-jp-nf"
      "ryota2357/pleck-jp/pleck-jp"
      "sf-symbols"

      # Dev Tools
      "docker-desktop"
      "dotnet-sdk"
      "drawio"
      "fontforge-app"
      "obsidian"
      "tailscale-app"
      "unity-hub"

      # Social
      "discord"
      "slack"
      "zoom"
      "zulip"

      # macOS improvements
      "alfred"
      "hhkb"
      "hiddenbar"
      "iina"
      "karabiner-elements"
      "keycastr"
      "logi-options+"
      "nikitabobko/tap/aerospace"
      "obs"
      "skim"

      # AI
      # "chatgpt"
      # "claude"

      # Game
      "osu"
    ];

    masApps = {
      # Development
      "Xcode" = 497799835;
      "TestFlight" = 899247664;

      # Productivity
      "AS Timer" = 512464723;
      "Toggl Track" = 1291898086;

      # Safari Extensions
      "AdGuard for Safari" = 1440147259;
      "Dark Reader for Safari" = 1438243180;
    };
  };
}
