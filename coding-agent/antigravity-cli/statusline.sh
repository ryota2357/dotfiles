#!/usr/bin/env bash

input=$(cat)

IFS=$'\n' read -r -d '' model ctx_used ctx_total five_pct five_reset seven_pct seven_reset cwd mode width <<EOF
$(jq -r '
  (.model.display_name // "n/a"),
  (.context_window.used_percentage // 0 | floor),
  (.context_window.context_window_size // 0 | if . >= 1000000 then "\((. / 1000000 | round))M" else "\((. / 1000 | round))K" end),
  ((1 - (.quota["gemini-5h"].remaining_fraction // 1)) * 100 | floor),
  (.quota["gemini-5h"].reset_time | try fromdate catch "-"),
  ((1 - (.quota["gemini-weekly"].remaining_fraction // 1)) * 100 | floor),
  (.quota["gemini-weekly"].reset_time | try fromdate catch "-"),
  (.workspace.current_dir // "n/a"),
  (.cycle_mode // "default"),
  (.terminal_width // 80)
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

case "$mode" in
  "accept-edits") color="\033[38;5;114m" ;;
  "plan")         color="\033[38;5;75m" ;;
  "default")      color="\033[38;5;242m" ;;
  *)              color="\033[38;5;226m" ;;
esac

left="$model | $ctx_used% / $ctx_total | 5h: $five_pct% / $fmt_5h | 7d: $seven_pct% / $fmt_7d | ${cwd/#$HOME/\~}"
pad=$(( width - ${#left} - ${#mode} ))

if (( pad > 0 )); then
  echo -e "\033[38;5;242m$left\033[0m$(printf '%*s' "$pad" '')${color}${mode}\033[0m"
else
  echo -e "\033[38;5;242m$left\033[0m | ${color}${mode}\033[0m"
fi
