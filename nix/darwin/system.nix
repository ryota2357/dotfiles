{
  stateVersion = 5;
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
      ShowPathbar = true;
    };
    dock = {
      autohide = true;
      show-recents = false;
      orientation = "bottom";
      largesize = 128;
      tilesize = 48;
      persistent-apps = [];
    };
    trackpad = {
      Clicking = true;
    };
  };
}
