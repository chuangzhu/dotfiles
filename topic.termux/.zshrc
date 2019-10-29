export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin"
eval $(salias -i)

export TERM=xterm-256color

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
alias gs='git status'
alias mv='mv -i'
alias cp='cp -i'
alias proxychains=proxychains4
alias xc=proxychains

function wd() {
    wkdict $1 | less
}

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
    http_proxy='http://localhost:10809'
    [[ $1 ]] && http_proxy="http://localhost:$1"
    # $ proxy1 socks5 1080
    [[ $2 ]] && http_proxy="$1://localhost:$2"
    [[ $3 ]] && http_proxy="$1://$2:$3"
    local proxy
    for proxy in http_proxy HTTP_PROXY https_proxy HTTPS_PROXY; do
            export $proxy="$http_proxy"
    done
}

