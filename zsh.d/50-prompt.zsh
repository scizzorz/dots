# === Prompt utilities =========================================================
# used by prompt to show an @ sign if a Python virtualenv is active
export VIRTUAL_ENV_DISABLE_PROMPT=true

show_venv() {
  # add a blank space if there's an active environment
  if [[ -n "${VIRTUAL_ENV}" ]] || [[ -n "${HERMIT_ENV}" ]]; then
    echo -n " "
  fi

  # use an @ to indicate a Python virtualenv
  if [[ -n "${VIRTUAL_ENV}" ]]; then
    echo -n "@"
  fi

  # use a $ to indicate a Hermit env
  if [[ -n "${HERMIT_ENV}" ]]; then
    echo -n "$"
  fi

  # add a newline if there were any active envs
  if [[ -n "${VIRTUAL_ENV}" ]] || [[ -n "${HERMIT_ENV}" ]]; then
    echo ""
  fi
}

# used by prompt to show git branch / commit / status
show_git_ref() {
  local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local git_commit="$(git rev-parse --short=0 HEAD 2>/dev/null)"

  if [[ -z "${git_branch}" ]]; then
    # no repo, don't display anything
    return
  elif [[ "${git_branch}" == "HEAD" ]]; then
    # no branch, just display the commit
    echo -n " $git_commit"
  else
    # display the branch and commit
    echo -n "/$git_branch $git_commit"
  fi

  # add a * if there's dirty changes
  if git diff --no-ext-diff --quiet; then
  else
    echo -n "*"
  fi
}

show_work_dir() {
  local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [[ -z "${git_root}" ]]; then
    # no repo: display the full path
    print -nrD "${PWD}"
  else
    # repo: display the repo name + path within repo
    local repo_name="$(basename ${git_root})"
    echo -n "${repo_name}${PWD##${git_root}}"
  fi
}

# === Prompt ===================================================================
# enable argument substitution in the prompt
setopt PROMPT_SUBST

# enable %-escaped fancy codes
setopt PROMPT_PERCENT

local black=$'\033[30m'
local green=$'\033[32m'
local red=$'\033[31m'
local reset=$'\033[0m'
local white=$'\033[37m'

export PROMPT_COLOR=$'\033[96m' # bright cyan
export PROMPT_PREFIX="${white}%m " # hostname
[ -f ~/dots/prompt.sh ] && source ~/dots/prompt.sh

# add a % to the prompt to indicate suspended jobs
local job_indicator="%(1j, %%,)"
local delimiter="%(?,${green},${red})» ${reset}"

export PROMPT="${PROMPT_PREFIX}${PROMPT_COLOR}\$(show_work_dir)${white}\$(show_git_ref)\$(show_venv)${job_indicator} ${delimiter}%b"

# === Window titles=============================================================
function precmd {
  # precmd runs before each prompt is displayed
  local exit_status=$?
  if [[ "${exit_status}" -ne 0 ]]; then
    psvar[1]=" !"
  else
    psvar[1]=
  fi
  print -Pn "\e]0;%m %~%1v\a"
}

function preexec {
  # preexec runs after pressing enter but before the command runs
  print -Pn "\e]0;» $1\a"
}
