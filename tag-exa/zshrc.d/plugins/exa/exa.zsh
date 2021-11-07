# use exa instead of ls.
if type exa > /dev/null; then
  alias lss="/bin/ls"
  ls() {
    if [ "$1" = -A ]; then
      # exa does not support -A flag.
      # Some scripts will use ls -A to check for empty directories, so fall back to ls in these cases.
      /bin/ls -A
    else
      command exa --icons --header "$@"
    fi
  }
fi