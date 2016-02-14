# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

READLINK='readlink -f'
[[ $(uname) == 'Darwin' ]] && READLINK='readlink'
BASHRC=$($READLINK ${BASH_ARGV[0]})
DOTFILES_DIR="${BASHRC%/*}"

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

set -o vi

alias ls='ls --color=auto'
alias view='vi -R'
alias repair_space="sed -i 's/\xc2\xa0/ /g'"
alias cdmaster='cd /Users/saf/Dropbox/Technikum/MIC/MasterArbeit/MasterarbeitLatex'
alias fig='docker-compose'

export EDITOR=vim
export PS1="\u@\h:\w # "
export RSYNC_PASSWORD='mysecret'
export LANG='en_US.UTF-8'

[ -f "${DOTFILES_DIR}/prompt.sh" ] && . ${DOTFILES_DIR}/prompt.sh

### Importet from MAC ###
if [[ `uname` == "Darwin" ]]; then
	if [ -f ~/.git-completion.bash ]; then
		. ~/.git-completion.bash
	fi
	# Include FINK
	. /sw/bin/init.sh
	export PATH=~/bin:~/packer:$PATH
	export LC_CTYPE=en_US.utf-8
	export LESS=FRSX
	export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
	export CLICOLOR=1
	export PATH=/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/bin:/usr/local/sbin:~/bin:$PATH

	export WORKON_HOME=$HOME/devel/virtualenvs/
	export PROJECT_HOME=$HOME/devel/
	source /sw/bin/virtualenvwrapper.sh
	export PATH=$PATH:$HOME/devel/hrng/bin
	ssh-add -L >/dev/null || ssh-add
	. /Users/saf/.openshift/bash_autocomplete
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


X_SCLS=" "

if [[ -f /opt/rh/ruby193/enable ]] ; then
	. /opt/rh/ruby193/enable
	export X_SCLS="ruby193"
fi

if [[ $USER == 'hr' ]] ; then
	. /opt/rh/python27/enable
	export X_SCLS="$X_SCLS python27"
	. /opt/hr/virtualenv/bin/activate
	export PATH=/usr/pgsql-9.3/bin/:$PATH
fi


HRNG_IMAGE_DIR="/home/saf/diwa-images"
[[ $(hostname -f) == 'diwa.home' ]] && HRNG_IMAGE_DIR=/home/saf/diwa/images
export HRNG_IMAGE_DIR

