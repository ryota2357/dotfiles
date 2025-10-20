{ pkgs, ... }:
let
  writeShellScript =
    name: text:
    pkgs.writeShellScript name ''
      set -e
      fail() {
        echo "Error: $1" >&2
        exit 1
      }
      exec_var_or_fail() {
        local var_name="$1"
        shift
        local var_value="''${!var_name}"
        if [ -z "$var_value" ]; then
          fail "$var_name is not set."
        fi
        exec "$var_value" "$@"
      }
      ${text}
    '';
in
{
  home.packages = with pkgs; [
    direnv
    nix-direnv
  ];

  xdg.configFile = {
    "direnv/lib/nix-direnv.sh".source = "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";

    "direnv/direnvrc".text = ''
      if ! command -v nom > /dev/null; then
        return
      fi
      export DIRENV_ORIGINAL_NIX=$(command -v nix)
      export DIRENV_ORIGINAL_NOM=$(command -v nom)
      export DIRENV_USE_NIX_WRAPPER=1
      export DIRENV_CUSTOM_BIN_DIR="$(dirname ''${BASH_SOURCE:-$0})/bin"
      export PATH="$DIRENV_CUSTOM_BIN_DIR:$PATH"
    '';

    "direnv/bin/nix".source = writeShellScript "direnv-bin-nix" ''
      if [ "$DIRENV_USE_NIX_WRAPPER" = "1" ]; then
        for arg in "$@"; do
          if [ "$arg" = '--help' ]; then
            exec_var_or_fail 'DIRENV_ORIGINAL_NIX' "$@"
          fi
        done
        case "$1" in
          build|shell|develop)
            export DIRENV_USE_NIX_WRAPPER=0  # Prevent recursion
            exec_var_or_fail 'DIRENV_ORIGINAL_NOM' "$@"
            ;;
        esac
      fi
      exec_var_or_fail 'DIRENV_ORIGINAL_NIX' "$@"
    '';

    "direnv/bin/nom".source = writeShellScript "direnv-bin-nom" ''
      export DIRENV_USE_NIX_WRAPPER=0  # Prevent recursion
      exec_var_or_fail 'DIRENV_ORIGINAL_NOM' "$@"
    '';

    "direnv/bin/sudo".source = writeShellScript "direnv-bin-sudo" ''
      if [ -z "$DIRENV_CUSTOM_BIN_DIR" ]; then
        fail 'Error: DIRENV_CUSTOM_BIN_DIR is not set.'
      fi
      if [[ ":$PATH:" != *":$DIRENV_CUSTOM_BIN_DIR:"* ]]; then
        fail "Error: DIRENV_CUSTOM_BIN_DIR ($DIRENV_CUSTOM_BIN_DIR) is not found in PATH."
      fi
      path_remove() {
        local path_i result target="$1"
        declare -a path_array results
        IFS=: read -ra path_array <<< "$PATH"
        for path_i in "''${path_array[@]}"; do
          if [[ "$path_i" != "$target" ]]; then
            results+=("$path_i")
          fi
        done
        result=$(IFS=:; echo "''${results[*]}")
        export PATH="$result"
      }
      path_remove "$DIRENV_CUSTOM_BIN_DIR"
      /usr/bin/sudo "$@"
      export PATH="$DIRENV_CUSTOM_BIN_DIR:$PATH"
    '';
  };
}
