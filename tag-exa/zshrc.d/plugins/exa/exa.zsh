# use exa instead of ls.
if type exa > /dev/null; then
  alias lss="/bin/ls"
  ls() {
    if [ "$1" = -A ]; then
      /bin/ls -A
    else
      command exa --icons --header "$@"
    fi
  }
fi