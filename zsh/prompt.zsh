# used by prompt to show an @ sign if a Python virtualenv is active
export VIRTUAL_ENV_DISABLE_PROMPT=true
parse_venv() {
  if [ "$VIRTUAL_ENV" ]; then
    echo " @"
  fi
}

# used by prompt to show git branch / commit / status
parse_git_dir() {
  local GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local GIT_COMMIT="$(git rev-parse --short=0 HEAD 2>/dev/null)"
  local GIT_ALL="$(git status --porcelain 2>/dev/null | wc -l)"
  if [[ -z $GIT_BRANCH ]]; then
    # no repo
  elif [[ $GIT_BRANCH = "HEAD" ]]; then
    echo -n " $GIT_COMMIT"
  else
    echo -n "/$GIT_BRANCH $GIT_COMMIT"
  fi
  if [ $GIT_ALL -gt "0" ]; then
    echo -n "*"
  fi
}

# set up prompt
export PROMPT_COLOR=$'\033[96m' # bright cyan
export PROMPT_PREFIX='%{$fg_no_bold[white]%}%m ' # hostname
[ -f ~/dots/prompt.sh ] && source ~/dots/prompt.sh

setopt PROMPT_SUBST
setopt PROMPT_PERCENT
export PROMPT=$PROMPT_PREFIX'%{$fg_no_bold[white]%}%{'$PROMPT_COLOR'%}%~%{$fg_no_bold[white]%}$(parse_git_dir)$(parse_venv)%(1j, %%,) %(?,%{$fg_no_bold[green]%},%{$fg_no_bold[red]%})» %{$reset_color%}%b'

# set up window titles
function precmd {
  local exit_status=$?
  if [ $exit_status -ne 0 ]; then
    psvar[1]=" !"
  else
    psvar[1]=
  fi
  print -Pn "\e]0;%m %~%1v\a"
}

function preexec {
  print -Pn "\e]0;» $1\a"
}
