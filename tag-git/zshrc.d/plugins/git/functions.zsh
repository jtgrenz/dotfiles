
git-update-master() {
  echo "Syncing master with: git checkout --quiet --detach; git fetch origin master:master; git checkout --quiet -"
  command git checkout --quiet --detach; git fetch origin master:master; git checkout --quiet -
}

git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

git config --global core.hookpath ~/.dotfiles/tag-git/githooks
