# built in configuration settings for zsh
# for antibody/antigen plugins, use _plugins.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

#######################################
############ Zshell Comp ##############
#######################################

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

#######################################
######## Zshell Set/UnsetOpts #########
#######################################

setopt hist_ignore_all_dups         # remove older duplicate entries from history
setopt hist_reduce_blanks           # remove superfluous blanks from history items
setopt inc_append_history           # save history entries as soon as they are entered
# setopt share_history              # share history between different instances of the shell
setopt no_share_history             # stop sharing history between instances of the shell
unsetopt share_history              # unset share_history if it was set somewhere

setopt auto_cd                      # cd by typing directory name if it's not a command
setopt correct_all                  # autocorrect commands

setopt auto_list                    # automatically list choices on ambiguous completion
setopt auto_menu                    # automatically use menu completion
setopt always_to_end                # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
bindkey '^[[Z' reverse-menu-complete # allow shift tab to cycle backwards in completions

unset zle_bracketed_paste


#######################################
########### Zshell Misc ##############
#######################################

export LESS='-g -i -M -R -S -w -z-4' # allow scrolling with mouse in less

ZSH_AUTOSUGGEST_USE_ASYNC=true
