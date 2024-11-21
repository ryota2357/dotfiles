{ nixpkgs }:
let
  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-darwin"
    "x86_64-linux"
  ];
  eachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

  shellScriptHeader = ''
    set -euo pipefail
    ESC=$(printf '\033')
    message() {
      printf "''${ESC}[32m==>''${ESC}[m ''${ESC}[1m%s''${ESC}[m\n" "$1"
    }
  '';

  getExe = nixpkgs.lib.getExe;
in
eachSystem (pkgs: {

  home-manager-switch = {
    type = "app";
    program = toString (
      pkgs.writeShellScript "home-manager-switch" ''
        ${shellScriptHeader}
        message "home-manager switch --flake .#$1"
        ${getExe pkgs.home-manager} switch --flake .#$1
      ''
    );
  };

  nix-darwin-switch = {
    type = "app";
    program = toString (
      pkgs.writeShellScript "nix-darwin-switch" ''
        if [[ ! "${pkgs.system}" =~ ^(aarch64|x86_64)-darwin$ ]]; then
          echo "System is not supported: ${pkgs.system}" >&2
          exit 1
        fi
        ${shellScriptHeader}
        message "nix-darwin switch --flake .#$1"
        nix run nix-darwin -- switch --flake .#$1
        message "brew upgrade"
        brew upgrade
      ''
    );
  };

  fmt = {
    type = "app";
    program = toString (
      pkgs.writeShellScript "fmt" ''
        ${shellScriptHeader}
        while true; do
          if [[ -f flake.nix ]]; then
            break
          fi
          if [[ "$(pwd)" == "/" ]]; then
            echo "flake.nix not found." >&2
            exit 1
          fi
          cd ..
        done
        message "nixfmt"
        ${getExe pkgs.nixfmt-rfc-style} ./flake.nix ./nix
        message "shfmt"
        ${getExe pkgs.shfmt} -i 2 -w ./bin/* ./scripts/*.sh
        message "stylua"
        ${getExe pkgs.stylua} ./vim/lua
      ''
    );
  };
})
