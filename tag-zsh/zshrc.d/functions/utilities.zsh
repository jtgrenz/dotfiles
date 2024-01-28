
#Usage: whoisport $portnumber
whoisport() {
  lsof -nP -i4TCP:$1;
}

#Usage: killport $portnumber $kill_options
killport() {
  kill $2 $(lsof -t -i4TCP:$1)
}

# RCM tools rely on hostname which is not POSIX and does not always behave as expected on MacOS. Manually set
# the Hostname flag to use the $HOST envvar.
rcup() {
    command rcup -B $HOST "$@"
}

rcdn() {
    command rcdn -B $HOST "$@"
}

# prints path with each entry on a new line
prettypath() {
  tr ':' '\n' <<< "$PATH"
}
