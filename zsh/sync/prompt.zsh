__signal_code_string() {
    local ret=""
    for STATUS in $__save_pipestatus;
    do
        # man signal
        case $STATUS in
            0  ) ;;
            129) ret="${ret}|SIGHUP"   ;;   # terminate process    terminal line hangup
            130) ret="${ret}|SIGINT"   ;;   # terminate process    interrupt program
            131) ret="${ret}|SIGQUIT"  ;;   # create core image    quit program
            132) ret="${ret}|SIGILL"   ;;   # create core image    illegal instruction
            133) ret="${ret}|SIGTRAP"  ;;   # create core image    trace trap
            134) ret="${ret}|SIGABRT"  ;;   # create core image    abort program (formerly SIGIOT)
            135) ret="${ret}|SIGEMT"   ;;   # create core image    emulate instruction executed
            136) ret="${ret}|SIGFPE"   ;;   # create core image    floating-point exception
            137) ret="${ret}|SIGKILL"  ;;   # terminate process    kill program
            138) ret="${ret}|SIGBUS"   ;;   # create core image    bus error
            139) ret="${ret}|SIGSEGV"  ;;   # create core image    segmentation violation
            140) ret="${ret}|SIGSYS"   ;;   # create core image    non-existent system call invoked
            141) ret="${ret}|SIGPIPE"  ;;   # terminate process    write on a pipe with no reader
            142) ret="${ret}|SIGALRM"  ;;   # terminate process    real-time timer expired
            143) ret="${ret}|SIGTERM"  ;;   # terminate process    software termination signal
            144) ret="${ret}|SIGURG"   ;;   # discard signal       urgent condition present on socket
            145) ret="${ret}|SIGSTOP"  ;;   # stop process         stop (cannot be caught or ignored)
            146) ret="${ret}|SIGTSTP"  ;;   # stop process         stop signal generated from keyboard
            147) ret="${ret}|SIGCONT"  ;;   # discard signal       continue after stop
            148) ret="${ret}|SIGCHLD"  ;;   # discard signal       child status has changed
            149) ret="${ret}|SIGTTIN"  ;;   # stop process         background read attempted from control terminal
            150) ret="${ret}|SIGTTOU"  ;;   # stop process         background write attempted to control terminal
            151) ret="${ret}|SIGIO"    ;;   # discard signal       I/O is possible on a descriptor (see fcntl(2))
            152) ret="${ret}|SIGXCPU"  ;;   # terminate process    cpu time limit exceeded (see setrlimit(2))
            153) ret="${ret}|SIGXFSZ"  ;;   # terminate process    file size limit exceeded (see setrlimit(2))
            154) ret="${ret}|SIGVTALRM";;   # terminate process    virtual time alarm (see setitimer(2))
            155) ret="${ret}|SIGPROF"  ;;   # terminate process    profiling timer alarm (see setitimer(2))
            156) ret="${ret}|SIGWINCH" ;;   # discard signal       Window size change
            157) ret="${ret}|SIGINFO"  ;;   # discard signal       status request from keyboard
            158) ret="${ret}|SIGUSR1"  ;;   # terminate process    User defined signal 1
            159) ret="${ret}|SIGUSR2"  ;;   # terminate process    User defined signal 2
            *  ) ret="${ret}|${STATUS}";;
        esac
    done

    if [ ${#ret} -eq 0 ]; then
        echo ""
    else
        echo "[${ret[2,-1]}]"
    fi
}

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
  local cmd_status="%F{1}`__signal_code_string`%f"
  echo "${cmd_status} ${time}"
}

precmd() {
  __save_pipestatus=("${pipestatus[@]}")
  PROMPT=`__left-prompt`
  RPROMPT=`__right-prompt`
}
