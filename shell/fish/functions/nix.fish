function nix --description 'Wrapper for nix command that shows untracked files on failure'
  command nix $argv
  set -l exit_code $status
  if test $exit_code -ne 0
    set -l untracked_files (git ls-files --others --exclude-standard)
    if test (count $untracked_files) -gt 0
      set -l red (printf '\033[31m')
      set -l yellow (printf '\033[33m')
      set -l bold (printf '\033[1m')
      set -l reset (printf '\033[0m')
      echo "" >&2
      echo "$red$bold"nix command failed!"$reset" >&2
      echo "$yellow"Did you forget to "$bold"git add"$reset" "$yellow"these new files?"$reset" >&2
      for file in $untracked_files
        if string match -q "*.nix" $file
          echo "  $bold$file$reset" >&2
        else
          echo "  $file" >&2
        end
      end
    end
  end
  return $exit_code
end
