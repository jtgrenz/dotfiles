
# ZShell Configuration
#
# This .zshrc file is managed by the antibody plugin manager and is purposly
# kept modular. All configuration settings kept in sub folder in an attempt
# to keep the setup as organized as possible
#

local  INIT="$ZSH_CONFIG/initializers"
local  ANTIBODY="$ZSH_CONFIG/antibody"


############################################################
## Initializers
############################################################
source $INIT/zsh_options.zsh                # load general default zsh configurations
source $INIT/aliases.zsh                    # load default common aliases
source $INIT/powerlevel9k_config.zsh        # load prompt theme configuration. Must load before the theme plugin

############################################################
## Load Plugins from Antibody
############################################################
source $ANTIBODY/antibody.zsh               # load antibody wrapper 
source $ANTIBODY/plugin_settings.zsh        # load settings for plugins before plugins load
source $ANTIBODY/plugins_static.zsh         # load antibody plugins set in $ANTIBODY/_zsh_plugins.txt

############################################################
## Load Secondary config files
############################################################

# Load all custom functions.
if [ -d $ZSH_CONFIG/functions ]; then
  for file in $ZSH_CONFIG/functions/**/*.zsh; do
    source $file
  done
fi

# Load all first party plugins not added with antibody
if [ -d $ZSH_CONFIG/plugins ]; then
  for file in $ZSH_CONFIG/plugins/**/*.zsh; do
    source $file
  done
fi

# Load all host specific files
if [ -d $ZSH_CONFIG/$HOST ]; then
  for file in $ZSH_CONFIG/host/**/*.zsh; do
    source $file
  done
fi

