{
  system = {
    stateVersion = 6;
    primaryUser = "ryota2357";
    defaults = {
      NSGlobalDomain = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15; # 225 ms
        KeyRepeat = 2; # 30 ms
      };
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv"; # List view
        ShowPathbar = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "bottom";
        largesize = 128;
        tilesize = 48;
        persistent-apps = [ ];
        expose-animation-duration = 0.0;
        expose-group-apps = true;
      };
      spaces = {
        spans-displays = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerTapGesture = 2; # trigger Look up & data detectors
      };
    };
  };
}
