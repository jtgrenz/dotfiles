ghcontrib() {
  local contrib="/Users/jongrenning/src/github.com/Shopify/contribution-indicators/contributor_indicators";
  if [ $0 = "w" ]; then
    $contrib -u jtgrenz -s $(date -v-7d "+%Y-%m-%d") -e $(date "+%Y-%m-%d");
  else
   $contrib -u jtgrenz $@
   fi
}

ghcontribm() {
  local contrib="/Users/jongrenning/src/github.com/Shopify/contribution-indicators/contributor_indicators";
  $contrib -u jtgrenz;
}
