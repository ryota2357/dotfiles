alias c='clang++ -std=c++17 -stdlib=libc++ -Wall -O2'
alias a='./a.out'

alias ...='cd ../../'

alias clip='pbcopy'

alias vi='nvim'
alias vii='nvim .'

alias ta='tmux a -t'
alias tn='tmux new -s'
alias t='
if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  fi
  tmux attach-session -t "$ID"
fi'
