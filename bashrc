# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

[[ -x /usr/local/bin/greadlink ]] && export READLINK=/usr/local/bin/greadlink || export READLINK=$(which readlink)
BASHRC=$($READLINK ${BASH_ARGV[0]})
export DOTFILES_DIR="${BASHRC%/*}"

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

set -o vi

alias ..='cd ..'
alias l='ls -lh'
alias la='ls -lha'
alias view='vi -R'
alias repair_space="sed -i 's/\xc2\xa0/ /g'"
alias vi='vim'
alias doco='docker-compose'
alias dfh='/home/saf/dotfiles/dfh'

export EDITOR=vim
export PS1="\u@\h:\w # "
export LANG='en_US.UTF-8'

#[ -f "${DOTFILES_DIR}/prompt.sh" ] && . ${DOTFILES_DIR}/prompt.sh
[ -f "${DOTFILES_DIR}/functions.bash" ] && . ${DOTFILES_DIR}/functions.bash

if [[ $(uname) == 'Linux' ]] ; then
	alias ls='ls --color=auto'
fi

# Add bindir of dotfiles to path
export PATH=$DOTFILES_DIR/bin:$PATH

[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/apps/bin ]] && export PATH=$HOME/apps/bin:$PATH

which direnv 2>/dev/null >/dev/null && eval "$(direnv hook bash)" 

[[ -d ${HOME}/.bash_profile ]] && . ${HOME}/.bash_profile

which starship 2>/dev/null >/dev/null && eval "$(starship init bash)"

which fzf 2>/dev/null >/dev/null && eval "$(fzf --bash)"
