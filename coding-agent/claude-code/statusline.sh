#!/usr/bin/env bash

input=$(cat)

IFS=$'\n' read -r -d '' model ctx_used ctx_total five_pct five_reset seven_pct seven_reset cwd <<EOF
$(jq -r '
  (.model.display_name // "n/a"),
  (.context_window.used_percentage // 0 | floor),
  (.context_window.context_window_size // 0 | if . >= 1000 then "\((. / 1000 * 10 | round / 10))K" else . end),
  (.rate_limits.five_hour.used_percentage // 0 | floor),
  (.rate_limits.five_hour.resets_at // "-"),
  (.rate_limits.seven_day.used_percentage // 0 | floor),
  (.rate_limits.seven_day.resets_at // "-"),
  (.workspace.current_dir // "n/a")
' <<< "$input")
EOF

fmt_reset() {
  local epoch=$1 fmt=$2
  if [[ "$epoch" != "-" ]]; then
    LC_ALL=C date -d "@$epoch" "+$fmt" 2>/dev/null && return
    LC_ALL=C date -r "$epoch" "+$fmt" 2>/dev/null && return
  fi
  sed 's/%[a-zA-Z]/??/g' <<< "$fmt"
}
fmt_5h=$(fmt_reset "$five_reset" "%H:%M")
fmt_7d=$(fmt_reset "$seven_reset" "%a %H:%M")

echo "$model | $ctx_used% / $ctx_total | 5h: $five_pct% / $fmt_5h | 7d: $seven_pct% / $fmt_7d | ${cwd/#$HOME/\~}"
