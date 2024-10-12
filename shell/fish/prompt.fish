function __signal_code_to_string
  set -l ret
  for stat in $argv
    switch $stat
      # https://fishshell.com/docs/current/language.html#the-status-variable
      case 0;                                    # 0 is generally the exit status of commands if they successfully performed the requested operation.
      case 1;   set --append ret "Error"        # 1 is generally the exit status of commands if they failed to perform the requested operation.
      case 121; set --append ret "BadArgs"      # 121 is generally the exit status of commands if they were supplied with invalid arguments.
      case 123; set --append ret "BadCmdName"   # 123 means that the command was not executed because the command name contained invalid characters.
      case 124; set --append ret "NoMatch"      # 124 means that the command was not executed because none of the wildcards in the command produced any matches.
      case 125; set --append ret "CmdCantExec"  # 125 means that while an executable with the specified name was located, the operating system could not actually execute the command.
      case 126; set --append ret "CmdNotExec"   # 126 means that while a file with the specified name was located, it was not executable.
      case 127; set --append ret "CmdNotFound"  # 127 means that no function, builtin or command with the given name could be located.
      # man signal
      case 129; set --append ret "SIGHUP"     # terminate process    terminal line hangup
      case 130; set --append ret "SIGINT"     # terminate process    interrupt program
      case 131; set --append ret "SIGQUIT"    # create core image    quit program
      case 132; set --append ret "SIGILL"     # create core image    illegal instruction
      case 133; set --append ret "SIGTRAP"    # create core image    trace trap
      case 134; set --append ret "SIGABRT"    # create core image    abort program (formerly SIGIOT)
      case 135; set --append ret "SIGEMT"     # create core image    emulate instruction executed
      case 136; set --append ret "SIGFPE"     # create core image    floating-point exception
      case 137; set --append ret "SIGKILL"    # terminate process    kill program
      case 138; set --append ret "SIGBUS"     # create core image    bus error
      case 139; set --append ret "SIGSEGV"    # create core image    segmentation violation
      case 140; set --append ret "SIGSYS"     # create core image    non-existent system call invoked
      case 141; set --append ret "SIGPIPE"    # terminate process    write on a pipe with no reader
      case 142; set --append ret "SIGALRM"    # terminate process    real-time timer expired
      case 143; set --append ret "SIGTERM"    # terminate process    software termination signal
      case 144; set --append ret "SIGURG"     # discard signal       urgent condition present on socket
      case 145; set --append ret "SIGSTOP"    # stop process         stop (cannot be caught or ignored)
      case 146; set --append ret "SIGTSTP"    # stop process         stop signal generated from keyboard
      case 147; set --append ret "SIGCONT"    # discard signal       continue after stop
      case 148; set --append ret "SIGCHLD"    # discard signal       child status has changed
      case 149; set --append ret "SIGTTIN"    # stop process         background read attempted from control terminal
      case 150; set --append ret "SIGTTOU"    # stop process         background write attempted to control terminal
      case 151; set --append ret "SIGIO"      # discard signal       I/O is possible on a descriptor (see fcntl(2))
      case 152; set --append ret "SIGXCPU"    # terminate process    cpu time limit exceeded (see setrlimit(2))
      case 153; set --append ret "SIGXFSZ"    # terminate process    file size limit exceeded (see setrlimit(2))
      case 154; set --append ret "SIGVTALRM"  # terminate process    virtual time alarm (see setitimer(2))
      case 155; set --append ret "SIGPROF"    # terminate process    profiling timer alarm (see setitimer(2))
      case 156; set --append ret "SIGWINCH"   # discard signal       Window size change
      case 157; set --append ret "SIGINFO"    # discard signal       status request from keyboard
      case 158; set --append ret "SIGUSR1"    # terminate process    User defined signal 1
      case 159; set --append ret "SIGUSR2"    # terminate process    User defined signal 2
      case '*'; set --append ret $stat
    end
  end
  echo (string join '|' $ret)
end

function fish_prompt
  set -l dir (set_color yellow)(string replace "$HOME" '~' "$(pwd)")(set_color normal)
  set -l next $(set_color brgreen)"❯ "$(set_color normal)

  if test (git rev-parse --is-inside-work-tree 2> /dev/null)
    set -l branch_name (git rev-parse --abbrev-ref HEAD)
    set -l branch '\e[38;5;250m '$branch_name(set_color normal)
    echo -e "\n$dir $branch\n$next"
  else
    echo -e "\n$dir\n$next"
  end
end

function fish_right_prompt
  set -l cmd_status (__signal_code_to_string $pipestatus)
  set -l time '\e[38;5;242m'(date '+%H:%M')(set_color normal)

  if test -z $cmd_status
    echo -e $time
  else
    echo -e (set_color red)"[$cmd_status] "(set_color normal)$time
  end
end
