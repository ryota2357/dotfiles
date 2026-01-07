ghq() {
  if [ $# -eq 0 ]; then
    local repo_path
    repo_path=$(ghq list | fzf --height 40% --reverse)
    if [[ -n "$repo_path" ]]; then
      cd "$(ghq root)/$repo_path"
    fi
  else
    command ghq "$@"
  fi
}

git() {
  if [ $# -eq 0 ]; then
    lazygit
  else
    command git "$@"
  fi
}

mkcd() {
  if [ $# -eq 0 ]; then
    echo "Pass a directory name"
    return 2
  fi
  mkdir -p "$1" && cd "$1"
}

mktouch() {
  if [ $# -eq 0 ]; then
    echo "Pass at least one file path"
    return 2
  fi
  for file in "$@"; do
    mkdir -p "$(dirname "$file")" && touch "$file"
  done
}

nix() {
  command nix "$@"
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    local untracked_files=()
    while IFS= read -r line; do
      [[ -n "$line" ]] && untracked_files+=("$line")
    done < <(git ls-files --others --exclude-standard)
    if [[ ${#untracked_files[@]} -gt 0 ]]; then
      local red yellow bold reset
      red="$(printf '\033[31m')"
      yellow="$(printf '\033[33m')"
      bold="$(printf '\033[1m')"
      reset="$(printf '\033[0m')"
      echo ""
      echo "${red}${bold}nix command failed!${reset}"
      echo "${yellow}Did you forget to ${bold}git add${reset} ${yellow}these new files?${reset}"
      for file in "${untracked_files[@]}"; do
        if [[ "$file" == *.nix ]]; then
          echo "  ${bold}$file${reset}"
        else
          echo "  $file"
        fi
      done
    fi
  fi
  return $exit_code
}
