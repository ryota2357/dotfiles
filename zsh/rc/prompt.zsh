left-prompt() {
  local dir="%F{11}%~%f"
  local next="%F{47}❯%f "
  echo -e "\n${user}${dir}\n${next}"
}
right-prompt() {
  local time="%F{242}%T%f"
  echo "${time}"
}

PROMPT=`left-prompt`
RPROMPT=`right-prompt`

unset -f left-prompt
unset -f right-prompt
