{
  nix = {
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
      warn-dirty = false;
      extra-substituters = [
        "https://ryota2357.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "ryota2357.cachix.org-1:1Biai//719bDFSnfV7FK0vKHw9C1b0S4/DQiNdkmWQo="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
