{
  optimise.automatic = true;
  gc = {
    automatic = true;
    interval = {
      Hour = 9;
      Minute = 0;
    };
    options = "--delete-older-than 10d";
  };
  settings = {
    experimental-features = "nix-command flakes";
    max-jobs = 8;
  };
}
