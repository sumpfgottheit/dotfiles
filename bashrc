# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

[[ -x /usr/local/bin/greadlink ]] && export READLINK=/usr/local/bin/greadlink || export READLINK=$(which readlink)

if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi


[[ -x /opt/homebrew/bin/mg ]] && alias magr="/opt/homebrew/bin/mg"
[[ -x /opt/homebrew/bin/vim ]] && alias vi="/opt/homebrew/bin/vi"

if command -v gls &>/dev/null; then
  alias ls='gls --color=auto'
  alias ll='gls -lah --color=auto'
else
  # Fallback, falls gls mal nicht verfügbar ist
  export CLICOLOR=1
  alias ls='ls -GH'
  alias ll='ls -lahGH'
fi

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
alias nano='vim'

export EDITOR=vim
export PS1="\u@\h:\w # "
export LANG='en_US.UTF-8'

# Add bindir of dotfiles to path
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/go/bin ]] && export PATH=$HOME/go/bin:$PATH
[[ -d $HOME/apps/bin ]] && export PATH=$HOME/apps/bin:$PATH

[[ -d /home/saf/.opencode/bin ]] && export PATH=/home/saf/.opencode/bin:$PATH

[[ -d ${HOME}/.bash_profile ]] && . ${HOME}/.bash_profile


which direnv 2>/dev/null >/dev/null && eval "$(direnv hook bash)" 
which starship 2>/dev/null >/dev/null && eval "$(starship init bash)"
which fzf 2>/dev/null >/dev/null && eval "$(fzf --bash)"

cat << EOF >> ~/.bash_profile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

