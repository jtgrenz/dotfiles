
git-update-master() {
  echo "Syncing master with: git checkout --quiet --detach; git fetch origin master:master; git checkout --quiet -"
  command git checkout --quiet --detach; git fetch origin master:master; git checkout --quiet -
}
