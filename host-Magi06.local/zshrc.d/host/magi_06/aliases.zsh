alias mun='ssh jtg733@garfield.cs.mun.ca'
alias mun-tun='ssh -D 8080 -f -C -q -N jtg733@garfield.cs.mun.ca'
alias sub='open -a Sublime\ Text\ 2'

## Requires .zshrc_SECRETS.zsh file which must remain local and not checked into github
alias getCheckout="curl -H 'Authorization: token $SHOPIFY_GITHUB_TOKEN' -H 'Accept: application/vnd.github.v3.raw' -O -L $SHOPIFY_GITHUB_CHECKOUT_V2"

alias "devup!"="git checkout master && git pull && dev up"
alias "devs!"="devup! && dev s"

# rebase shopify/shopify against the latest green master. Must be in repo
alias rebasegreenmaster='git rebase $(./script/ci_last_green_master)'

# open vimrc from wherever
alias vimrc="vim $HOME/.vimrc"

alias svim="nvim -u $HOME/.SpaceVim/init.vim"

alias devuf="dev up --only=ruby,bundler,database"
