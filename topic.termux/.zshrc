export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin"
eval $(salias -i)

export ZSH="/data/data/com.termux/files/home/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
  git
  debian
  go
  pip
)
source $ZSH/oh-my-zsh.sh
# source .antigen/bin/antigen.zsh

export EDITOR=vim
alias ':e'=$EDITOR
alias ':q'=exit

alias gut=git
alias lz=ls
alias yd=ydcv
alias pep8=pycodestyle
alias ds='du -hd 1'
alias rf='rm -rf'

alias clip=termux-clipboard-set

function sin() {
    eval $(ssh-agent)
    local a i
    for i in ~/.ssh/*; do
        if [ -f $i.pub ]; then
            a=(${a[@]} $i)
        fi
    done
    ssh-add ${a[@]}
}

gh='https://github.com'
mgh='git@github.com:genelocated'

function proxy1() {
    http_proxy='http://localhost:1080'
    [[ $1 ]] && http_proxy=$1
    export http_proxy
    export HTTP_PROXY=$http_proxy
    export https_proxy=$http_proxy
    export HTTPS_PROXY=$https_proxy
}

