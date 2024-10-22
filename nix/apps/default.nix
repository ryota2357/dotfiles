{ nixpkgs }:
let
  forAllSystems =
    f:
    builtins.foldl' (acc: system: acc // { ${system} = (f system); }) { } [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  shellScriptHeader = ''
    set -euo pipefail
    ESC=$(printf '\033')
    message() {
      printf "''${ESC}[32m==>''${ESC}[m ''${ESC}[1m%s''${ESC}[m\n" "$1"
    }
  '';
in
forAllSystems (
  system:
  let
    pkgs = import nixpkgs {
      inherit system;
    };
    getExe = pkgs.lib.getExe;
  in
  {
    home-manager-switch = {
      type = "app";
      program = toString (
        pkgs.writeShellScript "home-manager" ''
          ${shellScriptHeader}
          message "home-manager switch --flake .#$1"
          ${getExe pkgs.home-manager} switch --flake .#$1
        ''
      );
    };

    nix-darwin-switch = {
      type = "app";
      program = toString (
        pkgs.writeShellScript "home-manager" ''
          ${shellScriptHeader}
          message "nix-darwin switch --flake .#$1"
          nix run nix-darwin -- switch --flake .#$1
          message "brew upgrade"
          brew upgrade
        ''
      );
    };
  }
)
