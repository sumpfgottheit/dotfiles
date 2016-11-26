# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
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
alias cdmaster='cd /Users/saf/Dropbox/Technikum/MIC/MasterArbeit/MasterarbeitLatex'
alias fig='docker-compose'
alias vi='vim'

export EDITOR=vim
export PS1="\u@\h:\w # "
export RSYNC_PASSWORD='mysecret'
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
[[ -d $HOME/apps/bin ]] && export PATH=$PATH:$HOME/apps/bin

#export GREP_OPTIONS='--color=auto' 
#export GREP_COLOR='1;32'

if [[ $(hostname -s) == 'tuxedo-tweed' ]] || [[ $(hostname -s) == 'tuxedo-mint' ]] || [[ $(hostname -s) == 'tuxedo-arch' ]] ; then
    #
    # Virtualenv for Python 3
    #
    VIRTUALENV_WRAPPER=$(which virtualenvwrapper.sh)
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/devel
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
    export VIRTUALENVWRAPPER_VIRTUALENV_CLONE=$(which virtualenv-clone)
    source $VIRTUALENV_WRAPPER

fi

#
# Hochrechnung docker-compose-variablen
#
[[ -d $HOME/devel/hr ]] && export DOCKER_HOST_HR_DIR=$HOME/devel/hr

if [[ `uname` == "Darwin" ]]; then
	if [ -f ~/.git-completion.bash ]; then
		. ~/.git-completion.bash
	fi
	# Include FINK
	[ -f /sw/bin/init.sh ] && . /sw/bin/init.sh
	export PATH=~/bin:~/packer:$PATH
	export LC_CTYPE=en_US.utf-8
	export LESS=FRSX
	export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
	export CLICOLOR=1
	export PATH=/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/bin:/usr/local/sbin:~/bin:$PATH

	export WORKON_HOME=$HOME/devel/virtualenvs/
	export PROJECT_HOME=$HOME/devel/
	[ -f /sw/bin/virtualenvwrapper.sh ] && .  /sw/bin/virtualenvwrapper.sh
	export PATH=$PATH:$HOME/devel/hrng/bin
	ssh-add -L >/dev/null || ssh-add
	[ -f /Users/saf/.openshift/bash_autocomplete ] && . /Users/saf/.openshift/bash_autocomplete
	export PATH="/usr/local/heroku/bin:$PATH"
	export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"
	export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
fi

if [[ $(hostname -s) == 'safrhel' ]] ; then
	export PATH=/home/saf/bin:$PATH
	export WORKON_HOME=~/virtualenvs
	source /usr/bin/virtualenvwrapper.sh
	export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
	export CURL_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
fi

if [[ $(hostname -s) == 'flaskdev' ]] ; then
	[[ -d /opt/virtualenv_hr ]] && . /opt/virtualenv_hr/bin/activate
fi


#if [[ $USER == 'hr' ]] ; then
#	. /opt/rh/python27/enable
#	export X_SCLS="$X_SCLS python27"
#	. /opt/hr/virtualenv/bin/activate
#	export PATH=/usr/pgsql-9.3/bin/:$PATH
#fi


HRNG_IMAGE_DIR="/home/saf/diwa-images"
[[ $(hostname -f) == 'diwa.home' ]] && HRNG_IMAGE_DIR=/home/saf/diwa/images
export HRNG_IMAGE_DIR

if [[ $(hostname -s) == 'arps-devc' ]] ; then
    [[ -f /arps/virtualenv/bin/activate ]] && . /arps/virtualenv/bin/activate
    cd /arps/app
fi

