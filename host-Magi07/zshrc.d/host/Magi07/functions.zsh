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


## Bold Penguin
export BP_APP_ROOT="/Users/jongrenning/src/github.com/BoldPenguin"
# source $BP_APP_ROOT/pengie-raft/zsh-plugins/bp-pengie/bp-pengie.zsh
alias de='docker exec -it'
alias dlog='docker logs --tail 100'

# source $BP_APP_ROOT/pengie-raft/zsh-plugins/bp-pengie/bp-pengie.zsh
source $BP_APP_ROOT/pengie-raft/zsh-plugins/bp-pengie/bp-pengie-function.zsh
source $BP_APP_ROOT/pengie-raft/zsh-plugins/bp-pengie/raft.zsh