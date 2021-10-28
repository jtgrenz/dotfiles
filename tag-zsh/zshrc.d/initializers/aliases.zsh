
# Sane default aliases for zsh

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'

#alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up

alias afind='ack-grep -il'

# Misc

alias mun='ssh jtg733@garfield.cs.mun.ca'
alias mun-tun='ssh -D 8080 -f -C -q -N jtg733@garfield.cs.mun.ca'
alias sub='open -a Sublime\ Text\ 2'

alias zshrc='code ~/.zshrc.d/'


