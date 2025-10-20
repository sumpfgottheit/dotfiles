# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

[[ -x /usr/local/bin/greadlink ]] && export READLINK=/usr/local/bin/greadlink || export READLINK=$(which readlink)

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

set -o vi

if [[ $(uname) == 'Linux' ]] ; then
	alias ls='ls --color=auto'
fi
alias ..='cd ..'
alias l='ls -lh'
alias la='ls -lha'
alias view='vi -R'
alias vi='vim'

export EDITOR=vim
export PS1="\u@\h:\w # "
export LANG='en_US.UTF-8'

# Add bindir of dotfiles to path
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/go/bin ]] && export PATH=$HOME/go/bin:$PATH
[[ -d $HOME/apps/bin ]] && export PATH=$HOME/apps/bin:$PATH

which direnv 2>/dev/null >/dev/null && eval "$(direnv hook bash)" 

[[ -d ${HOME}/.bash_profile ]] && . ${HOME}/.bash_profile

which starship 2>/dev/null >/dev/null && eval "$(starship init bash)"

which fzf 2>/dev/null >/dev/null && eval "$(fzf --bash)"

which restish 2>/dev/null >/dev/null && eval "$(restish completion bash)"

which go-task 2>/dev/null >/dev/null && alias got='go-task'

# pnpm
export PNPM_HOME="/home/saf/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
