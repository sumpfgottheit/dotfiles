# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

READLINK='readlink -f'
[[ $(uname) == 'Darwin' ]] && READLINK='readlink'
BASHRC=$($READLINK ${BASH_ARGV[0]})
DOTFILES_DIR="${BASHRC%/*}"

set -o vi

alias ls='ls -h --color=auto'
alias la='ls -la'
alias l='ls -l'
alias ..='cd ..'
alias vi='vim'
alias view='vi -R'
alias repair_space="sed -i 's/\xc2\xa0/ /g'"

export EDITOR=vim
export PS1="\u@\h:\w # "
export RSYNC_PASSWORD='mysecret'
export LANG='en_US.UTF-8'

[ -f "${DOTFILES_DIR}/git_bash_prompt.sh" ] && . ${DOTFILES_DIR}/git_bash_prompt.sh

### Importet from MAC ###
if [[ `uname` == "Darwin" ]]; then
	if [[ $(echo $BASH_VERSION | cut -b1) == "4" ]] ; then
		if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
			. /opt/local/etc/profile.d/bash_completion.sh
		fi
	fi
	if [ -f ~/.git-completion.bash ]; then
		. ~/.git-completion.bash
	fi
	export PATH=~/packer:$PATH
	export LC_CTYPE=en_US.utf-8
	export LESS=FRSX
	export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
	export CLICOLOR=1
	export PATH=/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/bin:/usr/local/sbin:~/bin:/opt/local/libexec/gnubin:$PATH
	export MANPATH=/opt/local/share/man:$MANPATH 
	export ORACLE_HOME=/Users/saf/instantclient_10_2_32bit
	export DYLD_LIBRARY_PATH=$ORACLE_HOME
	alias sql="$ORACLE_HOME/sqlplus sa/support@//pythia.home:1521/wahldb"

	export WORKON_HOME=$HOME/devel/virtualenvs/
	export PROJECT_HOME=$HOME/devel/
	source /usr/local/bin/virtualenvwrapper.sh
	export PATH=$PATH:$HOME/devel/hrng/bin
	ssh-add -L >/dev/null || ssh-add
	. /Users/saf/.openshift/bash_autocomplete
	export PATH="/usr/local/heroku/bin:$PATH"
fi

if [[ $USER == 'hr' ]] ; then
	. /opt/rh/python27/enable
	export X_SCLS="python27 "
	. /opt/hr/virtualenv/bin/activate
	export HR_FLASK_CONFIG="/opt/hr/application/$(hostname -s).config.py"
fi


