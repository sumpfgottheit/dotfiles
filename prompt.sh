#!/bin/bash
#
# DESCRIPTION:
#
#   Set the bash prompt according to:
#    * the branch/status of the current git repository
#    * the branch of the current subversion repository
#    * the return value of the previous command
# 
# USAGE:
#
#   1. Save this file as ~/.git_svn_bash_prompt
#   2. Add the following line to the end of your ~/.profile or ~/.bash_profile:
#        . ~/.git_svn_bash_prompt
#
# AUTHOR:
# 
#   Scott Woods <scott@westarete.com>
#   West Arete Computing
#
#   Based on work by halbtuerke and lakiolen.
#
#   http://gist.github.com/31967


# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
       CYAN="\[\033[0;36m\]"
     ORANGE="\e[38;5;208m"
 COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
  return $?
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if  [[ ${git_status} =~ "working directory clean" ]] || [[ ${git_status} =~ "working tree clean" ]]; then 
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${RED}"
  fi
  
  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
  
  # Get the name of the branch.
  branch_pattern="On branch ([^${IFS}]*)"    
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  # Set the final branch string.
  GIT="${CYAN}git:${state}${branch}${remote}${COLOR_NONE}"
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="${GREEN}#${COLOR_NONE}"
  else
      PROMPT_SYMBOL="${RED}#${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
    PYTHON_VIRTUALENV=""
  else
    PYTHON_VIRTUALENV="${CYAN}venv:${YELLOW}`basename \"$VIRTUAL_ENV\"`${COLOR_NONE}"
  fi
}

function virtualenv_enabled {
	test -n "$VIRTUAL_ENV"
	return $?
}

function scl_enabled {
	[[ -n "$X_SCLS" ]] && return 0
	return 1
}

function set_scl () {
	if test -z "$X_SCLS" ; then
		SCLS=""
	else
		SCLS="${CYAN}scls:${YELLOW}${X_SCLS%% }${COLOR_NONE}"
	fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the 
  # return value of the last command.
  set_prompt_symbol $?

  if virtualenv_enabled || scl_enabled || is_git_repository ; then
		SCLS=""
		PYTHON_VIRTUALENV=""
		GIT=""
		scl_enabled && set_scl
		virtualenv_enabled && set_virtualenv
		is_git_repository && set_git_branch
		MY_PROMPT="${SCLS} ${PYTHON_VIRTUALENV} ${GIT}"
		MY_PROMPT=${MY_PROMPT/  / }
		MY_PROMPT=${MY_PROMPT/  / }
		MY_PROMPT=${MY_PROMPT/# /}
		MY_PROMPT=${MY_PROMPT/% /}
		MY_PROMPT="${LIGHT_GRAY}[${MY_PROMPT}${LIGHT_GRAY}]${COLOR_NONE}"
  else 
	MY_PROMPT=""
  fi
  
  USERPROMPT='\u'
  [[ $(id -u) == 0 ]] && USERPROMPT="${RED}\u${COLOR_NONE}"
  # Set the bash prompt variable.
  if [[ -n $TILIX_ID ]] ; then
      VTE_PWD_THING="$(__vte_osc7)"
  else
        VTE_PWD_THING=""
  fi
  PS1="$USERPROMPT@${ORANGE}\h${COLOR_NONE}:$(pwd) ${MY_PROMPT}\n ${PROMPT_SYMBOL} "
  PS1="$PS1$VTE_PWD_THING"
}


# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
