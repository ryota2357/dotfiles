function ghq --description 'A ghq command wrapper with fzf integration'
  if test (count $argv) -eq 0
    set -l repo_path (ghq list | fzf --height 40% --reverse)
    if test -n "$repo_path"
      cd (ghq root)/$repo_path
    end
  else
    command ghq $argv
  end
end
