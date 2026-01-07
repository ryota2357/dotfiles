function mktouch --description "Create a file and its parent directories"
  if test (count $argv) -eq 0
    echo "Pass at least one file path"
    return 2
  end

  for file in $argv
    mkdir -p (dirname $file)
    touch $file
  end
end
