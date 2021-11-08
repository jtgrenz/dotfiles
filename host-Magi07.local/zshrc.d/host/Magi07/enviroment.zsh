
## import local secrets to enviroment
if [[ -f $ZSH_CONFIG/secrets.zsh ]]; then
    source $ZSH_CONFIG/secrets.zsh
fi

# Load shopify dev tool
# [ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
export DEV_REAL_EVENTS='0'
# # load jdev tool
# [ -f ~/src/github.com/jtgrenz/jdev/jdev.sh ] && source ~/src/github.com/jtgrenz/jdev/jdev.sh

if [ -f ~/src/github.com/burke/minidev/dev.sh ]; then
  source ~/src/github.com/burke/minidev/dev.sh
fi

export BUNDLER_EDITOR='code'
export EDITOR="vi"

# _direnv_hook() {
#   eval "$(direnv export zsh 2> >( egrep -v -e '^direnv: (loading|export|unloading)' ))"
# };

export DIRENV_LOG_FORMAT="$(printf "\033[1;30mdirenv: %%s\033[0m")"
eval "$(direnv hook zsh)"
