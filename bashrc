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

# Newer ipython doesn't use readlin
# ipython profile create
IPY_CFG=~/.ipython/profile_default/ipython_config.py
if [[ ! -f ${IPY_CFG} ]] ; then
    mkdir -p ~/.ipython/profile_default/
    touch ${IPY_CFG}
fi
if ! grep -q "c.TerminalInteractiveShell.editing_mode" $IPY_CFG ; then
    echo "c.TerminalInteractiveShell.editing_mode = 'vi'" >> ${IPY_CFG}
else
    sed -r -i "s/#?c.TerminalInteractiveShell.editing_mode =.*/c.TerminalInteractiveShell.editing_mode = 'vi'/" ${IPY_CFG}
fi


if [[ $(uname) == 'Linux' ]] ; then
	alias ls='ls --color=auto'
fi

# Add bindir of dotfiles to path
export PATH=$DOTFILES_DIR/bin:$PATH
[[ -d $HOME/apps/bin ]] && export PATH=$HOME/apps/bin:$PATH

which direnv 2>/dev/null >/dev/null && eval "$(direnv hook bash)" 

[[ -d ${HOME}/.bash_profile ]] && . ${HOME}/.bash_profile

. "$HOME/.local/bin/env"
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

eval "$(starship init bash)"

### HSTR
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor,raw-history-view       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE}
}
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

export KUBECONFIG=~/.kube/config

