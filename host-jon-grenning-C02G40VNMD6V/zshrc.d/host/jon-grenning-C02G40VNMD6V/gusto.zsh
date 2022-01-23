# Gusto Updog
export PATH=$PATH:$HOME/workspace/updog/bin

source ~/.gusto/*

export YVM_DIR="/usr/local/opt/yvm"
if [[ $CI == "true" ]]; then
  [ -r $YVM_DIR/yvm.sh ] && source $YVM_DIR/yvm.sh
else
  [ -r $YVM_DIR/yvm.sh ] && source $YVM_DIR/yvm.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
