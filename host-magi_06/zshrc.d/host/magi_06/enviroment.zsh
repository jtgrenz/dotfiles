
## import local secrets to enviroment
if [[ -f $ZSH_CONFIG/secrets.zsh ]]; then
    source $ZSH_CONFIG/secrets.zsh
fi

# Load shopify dev tool
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

export BUNDLER_EDITOR='code'
