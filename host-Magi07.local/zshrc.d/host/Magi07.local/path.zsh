## Path Updates
# Default from oh-my-zsh
export PATH=$PATH:/usr/local/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/libexec

# Add home bin folder for local bins
export PATH=$HOME/bin:$PATH

# Heroku
export PATH="/usr/local/heroku/bin:$PATH"

# homebrew maybe?
export PATH=/usr/local/bin:$PATH

# Themekit default install path
PATH="$HOME/.themekit:$PATH"

export PATH=$HOME/Applications:$PATH

# OPAM configuration
. /Users/jongrenning/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
export PATH="/usr/local/sbin:$PATH"

export BP_DIR=$BP_APP_ROOT
export PATH="$BP_APP_ROOT/installer:$PATH"