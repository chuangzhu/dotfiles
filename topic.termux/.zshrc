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
alias yd=ydcv
alias pep8=pycodestyle
alias ds='du -hd 1'

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

ghub='https://github.com'
mhub='git@github.com:genelocated'

