function git --description 'A git command wrapper'
  if test (count $argv) -eq 0
    lazygit
  else
    command git $argv
  end
end
