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
  casks = [ ];
}
