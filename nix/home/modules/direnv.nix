{ pkgs, ... }:
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
      export ORIGINAL_NIX_COMMAND=$(command -v nix)
      export ORIGINAL_NOM_COMMAND=$(command -v nom)
      export NIX_USE_NOM_WRAPPER=1
      export DIRENV_CUSTOM_BIN_DIR="$(dirname ''${BASH_SOURCE:-$0})/bin"
      export PATH="$DIRENV_CUSTOM_BIN_DIR:$PATH"
    '';

    "direnv/bin/nix".source = pkgs.writeShellScript "direnv-bin-nix" ''
      if [ "$NIX_USE_NOM_WRAPPER" = "1" ] && [ $# -ge 1 ]; then
        case "$1" in
          build|shell|develop)
            export NIX_USE_NOM_WRAPPER=0  # Prevent recursion
            exec "$ORIGINAL_NOM_COMMAND" "$@"
          ;;
        esac
      fi
      if [ -n "$ORIGINAL_NIX_COMMAND" ]; then
        exec "$ORIGINAL_NIX_COMMAND" "$@"
      else
        echo "Error: ORIGINAL_NIX_COMMAND is not set and nix is not found in PATH." >&2
        exit 1
      fi
    '';

    "direnv/bin/nom".source = pkgs.writeShellScript "direnv-bin-nom" ''
      if [ -n "$ORIGINAL_NOM_COMMAND" ]; then
        export NIX_USE_NOM_WRAPPER=0  # Prevent recursion
        exec "$ORIGINAL_NOM_COMMAND" "$@"
      else
        echo "Error: ORIGINAL_NOM_COMMAND is not set and nom is not found in PATH." >&2
        exit 1
      fi
    '';

    "direnv/bin/sudo".source = pkgs.writeShellScript "direnv-bin-sudo" ''
      if [ -z "$DIRENV_CUSTOM_BIN_DIR" ]; then
        echo "Error: DIRENV_CUSTOM_BIN_DIR is not set." >&2
        exit 1
      fi
      if [[ ":$PATH:" != *":$DIRENV_CUSTOM_BIN_DIR:"* ]]; then
        echo "Error: DIRENV_CUSTOM_BIN_DIR ($DIRENV_CUSTOM_BIN_DIR) not found in PATH." >&2
        exit 1
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
