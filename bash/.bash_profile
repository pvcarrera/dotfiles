export PATH=/usr/local/bin:$PATH
export PATH=.bundle/bin:$PATH

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOUR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="Your[[:space:]]branch[[:space:]]is[[:space:]]([^ ]*)"

  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    elif [[ ${BASH_REMATCH[1]} == "behind" ]]; then
      remote="↓"
    else
      remote=""
    fi
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch=`__git_ps1`

  # Set the final branch string.
  BRANCH="${state}${branch}${remote}${COLOUR_NONE} "
}

function setup_prompt {
  # Setup the BRANCH variable
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  # This runs before the prompt and sets the title of the xterm* window.  If you set the title in the prompt
  # weird wrapping errors occur on some systems, so this method is superior
  echo -ne "\033]0;${USER}@${HOSTNAME%%.*}"
  echo -ne "\007"

  PS1="${GREEN}\w${COLOUR_NONE}${BRANCH}> "
}

export PROMPT_COMMAND=setup_prompt

# export PS1="${GREEN}\w${COLOUR_NONE}${BRANCH}> "  # Primary prompt with only a path
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias ll='ls -la'

alias gs='git status'export PATH=$HOME/bin:$PATH

eval "$(rbenv init -)"
