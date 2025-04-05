alias c='clang++ -std=c++17 -stdlib=libc++ -Wall -O2'
alias cg='clang++ -std=c++17 -stdlib=libc++ -g3'
alias a='./a.out'

alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias clip='pbcopy'

alias vi='nvim'
alias :q='exit'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

mkcd() {
  mkdir -p "$1" && cd "$1"
}

git() {
  if [ $# -eq 0 ]; then
    lazygit
  else
    command git "$@"
  fi
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

alias denops='deno run -A --no-lock ~/.cache/dein/repos/github.com/vim-denops/denops.vim/denops/@denops-private/cli.ts'
