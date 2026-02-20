#!/usr/bin/env bash

input=$(cat)

IFS=$'\n' read -r -d '' model ctx_used ctx_total cwd <<EOF
$(jq -r '
  (.model.display_name // "n/a"),
  (.context_window.used_percentage // 0 | floor),
  (.context_window.context_window_size // 0 | if . >= 1000 then "\((. / 1000 * 10 | round / 10))K" else . end),
  (.workspace.current_dir // "n/a")
' <<< "$input")
EOF

echo "$model | $ctx_used% / $ctx_total | ${cwd/#$HOME/\~}"
