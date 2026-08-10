# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

[[ -x /usr/local/bin/greadlink ]] && export READLINK=/usr/local/bin/greadlink || export READLINK=$(which readlink)

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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

if [[ $(uname) == 'Linux' ]]; then
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

## Add bindir of dotfiles to path
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/go/bin ]] && export PATH=$HOME/go/bin:$PATH
[[ -d $HOME/apps/bin ]] && export PATH=$HOME/apps/bin:$PATH

[[ -d ${HOME}/.bash_profile ]] && . ${HOME}/.bash_profile

which direnv 2>/dev/null >/dev/null && eval "$(direnv hook bash)"
which starship 2>/dev/null >/dev/null && eval "$(starship init bash)"
which fzf 2>/dev/null >/dev/null && eval "$(fzf --bash)"

source '/Users/saf/.bash_completions/skillgarden.sh'

source '/Users/saf/.bash_completions/generate-ai-config.sh'

# fastfetch writes to /dev/tty (not stdout) so its banner can never land
# inside direnv's captured JSON output on shell startup, which otherwise
# breaks direnv with: invalid character '.' looking for beginning of value
if [[ $- == *i* ]] && [[ $(uname) == 'Darwin' ]]; then
  [[ -x /opt/homebrew/bin/fastfetch ]] && /opt/homebrew/bin/fastfetch >/dev/tty
fi
