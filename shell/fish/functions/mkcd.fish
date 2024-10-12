function mkcd --description "Create a directory and cd into it"
  if test (count $argv) -eq 0
    echo "Pass a directory name"
    return 2
  end

  set dirname $argv[1]
  mkdir -p $dirname
  eval "cd" $dirname
end
