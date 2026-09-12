# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

[[ -x /usr/local/bin/greadlink ]] && export READLINK=/usr/local/bin/greadlink || export READLINK=$(which readlink)

# Homebrew shellenv (Linuxbrew / macOS ARM / macOS Intel)
for BREW in /home/linuxbrew/.linuxbrew/bin/brew /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [[ -x "$BREW" ]] && eval "$("$BREW" shellenv)" && break
done

# Homebrew bash-completion
if command -v brew >/dev/null 2>&1; then
  HOMEBREW_PREFIX="$(brew --prefix)"

  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  elif [[ -d "${HOMEBREW_PREFIX}/etc/bash_completion.d" ]]; then
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
    unset COMPLETION
  fi

  # Linuxbrew: bash-completion may leave `just` on the generic `_minimal`
  # fallback instead of loading Homebrew's runtime-generated completion.
  # Source it explicitly on Linux. macOS keeps the normal lazy-loading path.
  if [[ "$(uname)" == "Linux" ]] && \
     [[ -r "${HOMEBREW_PREFIX}/etc/bash_completion.d/just" ]]; then
    source "${HOMEBREW_PREFIX}/etc/bash_completion.d/just"
  fi
fi

# Alle Bash-Completions aus ~/.bash_completions/ laden
if [ -d "$HOME/.bash_completions" ]; then
  for file in "$HOME/.bash_completions/"*; do
    # Sicherstellen, dass die Datei existiert und lesbar ist (verhindert Fehler bei leerem Ordner)
    [ -r "$file" ] && source "$file"
  done
  unset file
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
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

export EDITOR=vim
export PS1="\u@\h:\w # "
export LANG='en_US.UTF-8'

## Add bindir of dotfiles to path
[[ -d $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH
[[ -d $HOME/go/bin ]] && export PATH=$HOME/go/bin:$PATH
[[ -d $HOME/apps/bin ]] && export PATH=$HOME/apps/bin:$PATH

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
command -v fzf >/dev/null 2>&1 && eval "$(fzf --bash)"

# fastfetch writes to /dev/tty (not stdout) so its banner can never land
# inside direnv's captured JSON output on shell startup, which otherwise
# breaks direnv with: invalid character '.' looking for beginning of value
if [[ $- == *i* ]] && [[ $(uname) == 'Darwin' ]]; then
  [[ -x /opt/homebrew/bin/fastfetch ]] && /opt/homebrew/bin/fastfetch >/dev/tty
fi

if [[ -d $HOME/.nvm ]] ; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
