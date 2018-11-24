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
  pip
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
alias clip=xclip
alias yaourt=yay

alias ds='du -hd 1'
alias gut=git
function sin() {
    eval $(ssh-agent)
    for i in ~/.ssh/id_rsa*
    do
        if ! echo $i | grep -q '.pub'; then
            ssh-add $i
        fi
    done
}
ghub='https://github.com'
mhub='git@github.com:genelocated'

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/zsh-users/zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval $(thefuck --alias)

