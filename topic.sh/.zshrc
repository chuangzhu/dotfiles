source $HOME/.profile
export SHELL=zsh

# https://github.com/ktr0731/salias
eval $(salias -i)

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  archlinux
  python
  go
)

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

command_not_found_handler() {
    /usr/bin/cnf-lookup $1
    echo "zsh: command not found: $1"
}

# export MANPATH="/usr/local/man:$MANPATH"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export EDITOR='/usr/bin/vim'

alias ':e'=$EDITOR
alias ':q'=exit
alias ds='du -hd -1'
alias rf='rm -rf'

alias clip=xclip
alias yaourt=yay
alias yd=ydcv
alias gut=git
alias xc='proxychains'

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
    http_proxy='socks5://localhost:1080'
    [[ $1 ]] && http_proxy="socks5://localhost:$1"
    export http_proxy
    export HTTP_PROXY=$http_proxy
    export https_proxy=$http_proxy
    export HTTPS_PROXY=$https_proxy
}

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# eval $(thefuck --alias)

