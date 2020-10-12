source $HOME/.profile
export SHELL=zsh

# https://github.com/ktr0731/salias
which salias > /dev/null && eval $(salias -i)

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
  golang
  yarn-autocompletions
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
du0() { du -hd 1 $1 | sort --human-numeric-sort --reverse }
alias rf='rm -rf'
alias gd^='git diff HEAD^'
alias gs='' # I don't need ghostscript
alias ip='ip --color=auto'

export    LESS_TERMCAP_md=$'\e[01;31m'
export    LESS_TERMCAP_me=$'\e[0m'
export    LESS_TERMCAP_us=$'\e[01;32m'
export    LESS_TERMCAP_ue=$'\e[0m'
export    LESS_TERMCAP_so=$'\e[45;93m'
export    LESS_TERMCAP_se=$'\e[0m'

alias clip=xclip
alias yaourt=yay
alias yd=ydcv
alias gut=git
alias xc='proxychains'
alias d='sudo docker'

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

function swap() {
    local tmpfile=.tmp-$$
    mv "$1" $tmpfile
    mv "$2" "$1"
    mv $tmpfile "$2"
}

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-autosuggestions
[[ $TERM = xterm-* ]] && {
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
}

# eval $(thefuck --alias)
# eval "$(gh completion -s zsh)"

# prefix a command with a ' ', the command won't be written to .zsh_history
setopt HIST_IGNORE_SPACE

export NO_PROXY="localhost,127.0.0.0"

export BAT_PAGER="less -R"

[[ -f '/usr/share/nnn/quitcd/quitcd.bash_zsh' ]] && . '/usr/share/nnn/quitcd/quitcd.bash_zsh'
_fff() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}
alias fff=_fff

