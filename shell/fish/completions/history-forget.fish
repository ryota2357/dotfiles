complete \
  --command history-forget \
  --no-files \
  --condition '__fish_is_first_arg' \
  --arguments '(
    for i in (seq (count $history) | head -1000)
      printf "%s\t%s\n" $i $history[$i]
    end
  )'
