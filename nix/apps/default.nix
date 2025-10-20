{ nixpkgs }:
let
  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-darwin"
    "x86_64-linux"
  ];
  eachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  getExe = nixpkgs.lib.getExe;
in
eachSystem (
  pkgs:
  let
    writeShellScript =
      name: script:
      toString (
        pkgs.writeShellScript name ''
          set -euo pipefail
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
          ESC=$(printf '\033')
          message() {
            printf "''${ESC}[32m==>''${ESC}[m ''${ESC}[1m%s''${ESC}[m\n" "$1"
          }
          ${script}
        ''
      );
  in
  {
    default = {
      type = "app";
      program = writeShellScript "default" ''
        choices=$(${getExe pkgs.gum} choose --no-limit --header="" --selected='*' \
          --cursor-prefix='○ ' --selected-prefix='● ' --unselected-prefix='○ ' \
          --cursor.foreground='75' --selected.foreground='75' \
          'darwin-rebuild switch' 'home-manager switch' 'brew upgrade')
        IFS=$'\n'
        for choice in $choices; do
          message "$choice"
          case "$choice" in
            'darwin-rebuild switch')
              if [[ ! "${pkgs.system}" =~ ^(aarch64|x86_64)-darwin$ ]]; then
                echo "System is not supported: ${pkgs.system}" >&2
              else
                sudo nix run nix-darwin -- switch --flake .#default
              fi
              ;;
            'home-manager switch')
              ${getExe pkgs.home-manager} switch --flake .#default
              ;;
            'brew upgrade')
              brew upgrade
              ;;
          esac
        done
        unset IFS
        ${getExe pkgs.noti} -t 'Nix App (dotfiles)' -m 'finished'
      '';
    };
  }
)
