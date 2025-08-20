function history-forget --description "Deletes the previous command or the command at a specific index from history"
  function _error_msg --argument msg
    printf "\e[31m%s\e[0m\n" "$msg" >&2
  end

  set -l target_index
  switch (count $argv)
    case 0
      if string match -q -- $history[1] (status function)
        set target_index 2
      else
        set target_index 1
      end
    case 1
      set -l input_index $argv[1]
      if not string match -qr '^[1-9]\d*$' -- "$input_index"
        _error_msg "Argument must be a positive integer."
        return 1
      end
      set target_index $input_index
    case '*'
      _error_msg "Too many arguments. Expecting 0 or 1."
      echo "Usage: $(status function) [index]" >&2
      return 1
  end

  if test "$target_index" -gt (count $history)
    _error_msg "History index $target_index does not exist."
    return 1
  end

  set -l command_to_delete $history[$target_index]
  echo "Delete the following command from history? (Index: $target_index)"
  printf "> \e[31m%s\e[0m\n" "$command_to_delete"

  set -l confirm
  read --prompt-str "[Y/n]: " --nchars 1 confirm
  switch (string lower "$confirm")
    case '' 'y'
      history delete --exact --case-sensitive -- "$command_to_delete"
      echo "Deleted."
    case '*'
      echo "Canceled."
      return 1
  end
end
