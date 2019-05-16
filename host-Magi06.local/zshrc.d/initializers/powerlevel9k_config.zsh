# Powerline Theme Config
#
# https://github.com/bhilburn/powerlevel9k#prompt-customization
#
# Nerd fonts https://github.com/ryanoasis/nerd-fonts

POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir custom_shopify_master_status vcs vi_mode_joined )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(chruby nvm node_version pyenv context background_jobs custom_tmux)

# Context
DEFAULT_USER=$USER

# Dir
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_from_right
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=''

POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

# Vi_mode
POWERLEVEL9K_VI_INSERT_MODE_STRING=">"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="<"
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND="clear"
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND="clear"

# ruby
POWERLEVEL9K_CHRUBY_BACKGROUND='clear'
POWERLEVEL9K_CHRUBY_FOREGROUND='red'
POWERLEVEL9K_CHRUBY_BACKGROUND='clear'

# Node and NVM
POWERLEVEL9K_NODE_VERSION_BACKGROUND='clear'
POWERLEVEL9K_NODE_VERSION_FOREGROUND='green'

# Python
POWERLEVEL9K_PYENV_BACKGROUND='clear'
POWERLEVEL9K_PYENV_FOREGROUND='106'
POWERLEVEL9K_PYTHON_ICON='\ue606'

# VCS
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="clear"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="magenta"

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"

POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"


# root_indicator
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"

# Time
POWERLEVEL9K_TIME_BACKGROUND="clear"
POWERLEVEL9K_TIME_FOREGROUND="cyan"

# Execution Time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'

# Background Jobs
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'

# General Styles
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "

# Buildkite

shopify_master_status() {
  if [ $(pwd) = '/Users/jongrenning/Development/Shopify/shopify' ]; then
    local buildstatus=$(curl -s $SHOPIFY_MASTER_BUILD_STATUS)
    local color='%F{yellow}'
    if [ ! -z "$buildstatus" ]; then
      [ $buildstatus = '{"status":"passing"}' ] && color='%F{green}'
      [ $buildstatus = '{"status":"failing"}' ] && color='%F{red}'
    fi
    echo -n "%{$color%}\ue729" # \ue729 is 
  fi
}

POWERLEVEL9K_CUSTOM_SHOPIFY_MASTER_STATUS="shopify_master_status"
POWERLEVEL9K_CUSTOM_SHOPIFY_MASTER_STATUS_BACKGROUND="clear"


# Tmux 

tmux_session() {
    if [[ -n "${TMUX+set}" ]]; then 
        local sessionid=$(tmux display-message -p "#S")
        local color='%F{yellow}'
        echo -n "%{$color%}\uf489 $sessionid"
    fi
}
 
POWERLEVEL9K_CUSTOM_TMUX="tmux_session"
POWERLEVEL9K_CUSTOM_TMUX_BACKGROUND="clear"
