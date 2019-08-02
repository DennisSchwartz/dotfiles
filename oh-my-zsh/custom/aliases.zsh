alias dcu="docker-compose up"
alias dc="docker-compose"
alias ds="docker service"
alias d="docker"
alias k="kubectl"
alias kgp="kubectl get po"

alias drun='docker run -it --network=host --rm -v $(pwd):/opt/work --workdir=/opt/work'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias showfiles=‘defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder’
