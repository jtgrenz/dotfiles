# use eza instead of ls.
if type eza > /dev/null; then
  alias lss="/bin/ls"
  ls() {
    if [ "$1" = -A ]; then
      # eza does not support -A flag.
      # Some scripts will use ls -A to check for empty directories, so fall back to ls in these cases.
      /bin/ls -A
    else
      command eza --icons --header --width=150 "$@"
    fi
  }
fi
