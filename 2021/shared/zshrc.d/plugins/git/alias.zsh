# Git
## git misc
alias gst='git status'
alias gco='git checkout'

## git-pull
alias gpull='git pull origin $(git_current_branch)'
alias gpl='gpull'

## git-push
alias gpp='git push origin $(git_current_branch)'
alias gpp!='gpp -f'
alias gppf='gpp!'

## git-rebase
alias grb='git rebase'
alias grbm='git fetch origin master && git rebase origin/master'

## git-commit
alias gcam='git commit --all -m'
alias gcaa='git commit --all --amend'
alias gcam!='gcam --no-verify'
alias gcaa!='gcaa --no-verify'

## Open files in edited in last commit in VSCode
alias gittrunk="git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"
alias gitresume="git diff origin/$(gittrunk)...HEAD --name-only | cat | xargs code"
alias psql9.6='/usr/local/Cellar/postgresql@9.6/9.6.21/bin/psql'