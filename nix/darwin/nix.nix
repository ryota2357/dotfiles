{
  optimise.automatic = true;
  gc = {
    automatic = true;
    interval = {
      Weekday = 7;
      Hour = 12;
      Minute = 0;
    };
    options = "--delete-older-than 10d";
  };
  settings = {
    experimental-features = "nix-command flakes";
    max-jobs = 8;
  };
}
