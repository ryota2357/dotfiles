__signal_code_string() {
  local ret=()
  for stat in $__save_pipestatus; do
    # https://tldp.org/LDP/abs/html/exitcodes.html
    case $stat in
      0  ) ;;
      1  ) ret+='Error'        ;;
      2  ) ret+='BuiltinError' ;;
      126) ret+='NoPermission' ;;
      127) ret+='NotFound'     ;;
      # man signal
      129) ret+='SIGHUP'    ;;   # terminate process    terminal line hangup
      130) ret+='SIGINT'    ;;   # terminate process    interrupt program
      131) ret+='SIGQUIT'   ;;   # create core image    quit program
      132) ret+='SIGILL'    ;;   # create core image    illegal instruction
      133) ret+='SIGTRAP'   ;;   # create core image    trace trap
      134) ret+='SIGABRT'   ;;   # create core image    abort program (formerly SIGIOT)
      135) ret+='SIGEMT'    ;;   # create core image    emulate instruction executed
      136) ret+='SIGFPE'    ;;   # create core image    floating-point exception
      137) ret+='SIGKILL'   ;;   # terminate process    kill program
      138) ret+='SIGBUS'    ;;   # create core image    bus error
      139) ret+='SIGSEGV'   ;;   # create core image    segmentation violation
      140) ret+='SIGSYS'    ;;   # create core image    non-existent system call invoked
      141) ret+='SIGPIPE'   ;;   # terminate process    write on a pipe with no reader
      142) ret+='SIGALRM'   ;;   # terminate process    real-time timer expired
      143) ret+='SIGTERM'   ;;   # terminate process    software termination signal
      144) ret+='SIGURG'    ;;   # discard signal       urgent condition present on socket
      145) ret+='SIGSTOP'   ;;   # stop process         stop (cannot be caught or ignored)
      146) ret+='SIGTSTP'   ;;   # stop process         stop signal generated from keyboard
      147) ret+='SIGCONT'   ;;   # discard signal       continue after stop
      148) ret+='SIGCHLD'   ;;   # discard signal       child status has changed
      149) ret+='SIGTTIN'   ;;   # stop process         background read attempted from control terminal
      150) ret+='SIGTTOU'   ;;   # stop process         background write attempted to control terminal
      151) ret+='SIGIO'     ;;   # discard signal       I/O is possible on a descriptor (see fcntl(2))
      152) ret+='SIGXCPU'   ;;   # terminate process    cpu time limit exceeded (see setrlimit(2))
      153) ret+='SIGXFSZ'   ;;   # terminate process    file size limit exceeded (see setrlimit(2))
      154) ret+='SIGVTALRM' ;;   # terminate process    virtual time alarm (see setitimer(2))
      155) ret+='SIGPROF'   ;;   # terminate process    profiling timer alarm (see setitimer(2))
      156) ret+='SIGWINCH'  ;;   # discard signal       Window size change
      157) ret+='SIGINFO'   ;;   # discard signal       status request from keyboard
      158) ret+='SIGUSR1'   ;;   # terminate process    User defined signal 1
      159) ret+='SIGUSR2'   ;;   # terminate process    User defined signal 2
      *  ) ret="${stat}"   ;;
    esac
  done
  echo "${(j:|:)ret}"
}

__left-prompt() {
  if [[ -n "$GHQ_ROOT" && "$PWD" =~ "^${GHQ_ROOT}/([^/]+)/([^/]+)/([^/]+)(/.*)?" ]]; then
    local owner=${match[2]}
    local repo=${match[3]}
    local subdir=${match[4]}
    local dir="%F{yellow} ${owner}/${repo}${subdir}%f"
  else
    local dir="%F{yellow}%~%f"
  fi
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) ]]; then
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    local branch=" %F{250} $branch_name%f"
  else
    local branch=''
  fi
  local next="%F{47}❯%f "
  echo -e "\n$dir$branch\n$next"
}

__right-prompt() {
  local cmd_status=$(__signal_code_string)
  local time="%F{242}%T%f"
  if [[ -z "$cmd_status" ]]; then
    echo "$time"
  else
    cmd_status="%F{1}[$cmd_status]%f"
    echo "$cmd_status $time"
  fi
}

precmd() {
  __save_pipestatus=("${pipestatus[@]}")
  PROMPT=`__left-prompt`
  RPROMPT=`__right-prompt`
}
