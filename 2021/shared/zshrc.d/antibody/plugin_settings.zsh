## Custom settings configuration for plugins


#######################################
## zsh-users/zsh-syntax-highlighting ##
#######################################

# Enable highlighers. Default is only main.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line cursor root)

# Set highlighting styles
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'

# Set custom highlight patterns
typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm*-rf*' 'fg=red,bold,underline')
ZSH_HIGHLIGHT_PATTERNS+=('rm*-fr*' 'fg=red,bold,underline')
