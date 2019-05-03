#!/bin/zsh
# This script is executed by launchd
# and is called from ~/Library/LaunchAgents/git_pull_master.plist

source ~/.zshrc

stamp(){
  echo "$(date "+%Y-%m-%d  %H:%M:%S:") $*"
}

run_dev () {
  # $1 - $RAILGUN_STATUS
  # $2 - $REPO
  if test -n "$1"; then
    stamp "Railgun is running. Lets dev up again."
    terminal-notifier -message "Running Dev Up & Down for $2" -title "Git Auto Updater"
    stamp "Dev up"
    dev up
    stamp "Dev up again incase of timeout"
    dev up
    stamp "Dev up complete"
  else
    stamp "Railgun is not running. Lets dev up and back down."
    terminal-notifier -message "Running Dev Up & Down for $2" -title "Git Auto Updater"
    stamp "Dev up"
    dev up
    stamp "Dev up again incase of timeout"
    dev up
    stamp "Dev down"
    stamp "Dev up/down complete"

  fi
}

stamp "==== Begining Git Auto Updater ===="


DEVELOPMENT=/Users/jongrenning/Development/Shopify
REPOS=( /shopify /partners /identity /documentation /help )
# MESSAGE=""

terminal-notifier -message "Starting Git Auto Update for $REPOS" -title "Git Auto Updater"

cd DEVELOPMENT
stamp "Changing to $DEVELOPMENT"

for REPO in $REPOS ; do
  stamp "======== $REPO ========="
  cd $DEVELOPMENT$REPO
  if [ -d .git ]; then
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    RAILGUN_STATUS=$(railgun status)
    stamp "Switched to $REPO @branch: $CURRENT_BRANCH and fetching..."
    git fetch -pq --tags
    LOCAL_BRANCHES=$(git branch -l | cut -c3- | tr "\n" " ")
    LOCAL_BRANCHES=("${(@s/ /)LOCAL_BRANCHES}")

    for BRANCH in ${LOCAL_BRANCHES[*]}; do
      # If a local branch does not track a remote, skip it
      REMOTE_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name $BRANCH@{u} 2> /dev/null) || continue;
      REMOTE_COMMITS=$(git log $BRANCH..$REMOTE_BRANCH --oneline | wc -l) # Remote commits not in my local
      LOCAL_COMMITS=$(git log $REMOTE_BRANCH..$BRANCH --oneline | wc -l) # Local commits not pushed to remote
      UPDATED_CURRENT_BRANCH=false
      stamp "On $REPO @ $BRANCH "
      if [[ $REMOTE_COMMITS != "0" ]]; then
          # If on a checked-out branch, only pull if all there are no uncomitted local changes. Skip otherwise
          # For other branches, merge remote changes
          if [[ "$CURRENT_BRANCH" = "$BRANCH" ]]; then
              if [[ "$(git status --porcelain)" = "" ]]; then
                stamp "On a clean branch. Pulling $BRANCH"
                PULL_STATUS=$(git pull -pq)
                if [[ $PULL_STATUS != "Already up-to-date." ]]; then
                  UPDATED_CURRENT_BRANCH=true
                fi
              else
                stamp "$BRANCH is dirty. Skip Pull."
              fi

          else
              stamp "Fetching $BRANCH"
              git fetch  origin $BRANCH:$BRANCH

          fi

          # MESSAGE+="$REMOTE_COMMITS new commits from '$REMOTE_BRANCH'.\n"
      fi
    done
    if [[ $UPDATED_CURRENT_BRANCH = true ]]; then
      run_dev $run_dev $RAILGUN_STATUS $REPO
    fi
  fi
  stamp "========= Completed $REPO ==========="
  echo
  echo
  echo
  echo
  echo
done

# MESSAGE_PARAM='display notification "$MESSAGE"'
# osascript -e $MESSAGE_PARAM

stamp "==== Completed Update ====="
echo
echo
echo
echo
echo

#   if [[ $CURRENT_BRANCH = master ]]; then;
#     stamp "Pulling master"
#     RAILGUN_STATUS=$(railgun status)
#     if test -n "$RAILGUN_STATUS"; then
#       stamp "Railgun is running. Lets dev up again."
#       dev up
#     else
#       stamp "Railgun is not running. Lets dev up and back down."
#       dev up && dev down
#     fi
#     git pull -q
#   else
#     stamp "Fetching latest changes"
#     git fetch -q
#   fi
#   stamp "==== Completed $REPO ====="
#   echo
#   echo
# done
