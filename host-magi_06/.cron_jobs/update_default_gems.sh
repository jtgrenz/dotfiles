#!/bin/sh
# This script is executed by launchd
# and is called from ~/Library/LaunchAgents/update_default_gems.plist
alias echo='echo $(date): "$1"'
source ~/.zshrc

GEMS=(solargraph rubocop rails bundler)

echo "Installing latest version of key gems in all rubies..."
terminal-notifier -title "Installing latest version of key gems in all rubies..."
echo "---"
for RUBY in "${RUBIES[@]}"; do
  ruby_version=(${(s:/:)RUBY})
  ruby_version=${ruby_version[3]}

  if [[ "$RUBY" = "/opt/rubies/2.1.0" ]] || [[ "$RUBY" = "/opt/rubies/2.1.5" ]] ; then
    # current 2.1.x builds don't have openSSL setup properly and it errors out
    # should maybe be rebuilt to support it, but I never use them and can't be bothered.
    continue
  fi
  chruby_use "$RUBY"
    for GEM in $GEMS ; do
      echo Ruby $ruby_version :: Installing latest version of $GEM
      gem install $GEM
    done
  chruby_reset
done

echo "Install complete"
terminal-notifier -title "Install of key gems complete"
echo "---"
