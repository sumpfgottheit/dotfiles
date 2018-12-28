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
alias dfh='df -h -T | grep -v -E "^tmpfs|devtmpfs"'
alias git="LANGUAGE=en_US git"
alias si="sudo -i"

export EDITOR=vim
export PS1="\u@\h:\w # "
export LANG='en_US.UTF-8'

[ -f "${DOTFILES_DIR}/prompt.sh" ] && . ${DOTFILES_DIR}/prompt.sh
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

#export GREP_OPTIONS='--color=auto' 
#export GREP_COLOR='1;32'

if [[ $(hostname -s) == 'safedora' ]] ; then
    #
    # Virtualenv for Python 3
    #
    VIRTUALENV_WRAPPER=$(which virtualenvwrapper.sh)
    export WORKON_HOME=$HOME/virtualenvs
    export PROJECT_HOME=$HOME/devel
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv-3.6)
    export VIRTUALENVWRAPPER_VIRTUALENV_CLONE=$(which virtualenv-clone-3)
    source $VIRTUALENV_WRAPPER

fi

if [[ $(hostname -s) == 'safrhel' ]] ; then
	export PATH=/home/saf/bin:$PATH
	export WORKON_HOME=~/virtualenvs
	source /usr/bin/virtualenvwrapper.sh
	export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
	export CURL_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
fi

[[ -n $WORKING_DIR ]] && [[ -d $WORKING_DIR ]] && cd $WORKING_DIR

export ANSIBLE_CONFIG=~/ansible/ansible.cfg

which direnv 2>/dev/null >/dev/null && eval "$(direnv hook bash)" 
which pipenv 2>/dev/null >/dev/null && eval "$(pipenv --completion)"

if [[ $(hostname -s) == 'tuxedo' ]] ; then
    ssh-add -l >/dev/null || ssh-add
fi

if [[ -d ${HOME}/.pyenv ]] ; then
    export PATH="${HOME}/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

[[ -d ${HOME}/.bash_profile ]] && . ${HOME}/.bash_profile
