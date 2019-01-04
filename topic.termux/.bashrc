alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias .....="cd ....."

alias ll="ls -l"
alias la="ls -a"

EC() {
    printf "\e[1;7;33mcode $?\e[m\n"
}
trap EC ERR
