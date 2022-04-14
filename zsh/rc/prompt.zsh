__left-prompt() {
  local dir="%F{11}%~%f"
  local next="%F{47}❯%f "

  if [ `git rev-parse --is-inside-work-tree 2> /dev/null` ]; then
    local branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    local branch="%F{250} ${branch_name}%f"
    echo -e "\n${dir} ${branch}\n${next}"
  else
    echo -e "\n${dir}\n${next}"
  fi
}
__right-prompt() {
  local time="%F{242}%T%f"
  echo "${time}"
}

precmd() {
  PROMPT=`__left-prompt`
}
RPROMPT=`__right-prompt`

# unset -f __left-prompt
# unset -f __right-prompt
