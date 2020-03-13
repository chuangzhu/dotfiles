source $HOME/.profile
export SHELL=zsh

# https://github.com/ktr0731/salias
eval $(salias -i)

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

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

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

ZSH_CUSTOM=$HOME/.config/oh-my-zsh
if [[ ! -d $ZSH_CUSTOM ]]; then
  mkdir -p $ZSH_CUSTOM
fi

source $ZSH/oh-my-zsh.sh

source /usr/share/doc/pkgfile/command-not-found.zsh

# export MANPATH="/usr/local/man:$MANPATH"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export EDITOR='/usr/bin/vim'

alias ':e'=$EDITOR
alias ':q'=exit
alias ds='du -hd 1 | sort --human-numeric-sort --reverse'
alias rf='rm -rf'
alias gd^='git diff HEAD^'
alias gs='' # I don't need ghostscript

alias clip=xclip
alias yaourt=yay
alias yd=ydcv
alias gut=git
alias xc='proxychains'
alias d='sudo docker'

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
    http_proxy='http://localhost:10086'
    [[ $1 ]] && http_proxy="http://localhost:$1"
    # $ proxy1 socks5 1080
    [[ $2 ]] && http_proxy="$1://localhost:$2"
    [[ $3 ]] && http_proxy="$1://$2:$3"
    local proxy
    for proxy in http_proxy HTTP_PROXY https_proxy HTTPS_PROXY; do
            export $proxy="$http_proxy"
    done
}

alias proxy0='unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY'

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-autosuggestions
[[ $TERM = xterm-* ]] && {
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
}

# eval $(thefuck --alias)

# prefix a command with a ' ', the command won't be written to .zsh_history
setopt HIST_IGNORE_SPACE

export NO_PROXY="localhost,127.0.0.0"

