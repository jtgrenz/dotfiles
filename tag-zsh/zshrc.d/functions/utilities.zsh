
#Usage: whoisport $portnumber
whoisport() {
  lsof -nP -i4TCP:$1;
}

#Usage: killport $portnumber $kill_options
killport() {
  kill $2 $(lsof -t -i4TCP:$1)
}
