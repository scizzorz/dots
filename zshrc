[ -z "$PS1" ] && return

# configure history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# turn off beepies
unsetopt beep

# ???
bindkey -e

# set up completion system
zstyle :compinstall filename '/home/john/.zshrc'
autoload -Uz compinit
compinit

# enable colors
autoload -U colors && colors

# used by prompt to show an @ sign if a Python virtualenv is active
export VIRTUAL_ENV_DISABLE_PROMPT=true
parse_venv() {
	if [ "$VIRTUAL_ENV" ]; then
		echo " @"
	fi
}

# used by prompt to show git branch / commit / status
parse_git_dir() {
	local GIT_BRANCH="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
	local GIT_COMMIT="$(git rev-list HEAD --abbrev-commit --abbrev=0 -n1 2>/dev/null)"
	local GIT_ALL="$(git status --porcelain 2>/dev/null | wc -l)"
	local GIT_MOD="$(git status --porcelain -uno 2>/dev/null | wc -l )"
	local GIT_UNT="$(($GIT_ALL-$GIT_MOD))"
	if [[ -z $GIT_BRANCH ]]; then
		# no repo
	elif [[ $GIT_BRANCH =~ "detached" ]]; then
		echo -n " $GIT_COMMIT"
	else
		echo -n "/$GIT_BRANCH $GIT_COMMIT"
	fi
	if [ $GIT_MOD -gt "0" ]; then
		echo -n " *$GIT_MOD"
	fi
	if [ $GIT_UNT -gt "0" ]; then
		echo -n " +$GIT_UNT"
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
  flag=$(date +%s)" "$(pwd)
  echo "$flag" >> ~/.active

  local exit_status=$?
  if [ $exit_status -ne 0 ]; then
    psvar[1]=" ✕"
  else
    psvar[1]=
  fi
  print -Pn "\e]0;%m %~%1v\a"
}

function preexec {
  print -Pn "\e]0;» $1\a"
}

# set up default editor
export EDITOR=vim

# for Rust (is this still used in 2019?)
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# $PATH nonsense
export PATH=./:$PATH
export PATH=~/dots/bin:$PATH
export PATH=~/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export PATH=~/scripts:$PATH
export PATH=~/pico-8:$PATH

# For Skim
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
bindkey -s '^f' '~/dots/bin/vf\n'

# For Wine
export WINEARCH=win32

# For Exa
export EXA_COLORS=$(cat ~/dots/exarc | grep -v '#' |tr '\n' ':')

# set up alises
alias ls='exa -F'
alias grep='grep -I'
alias it='git'
alias g='git'
alias im='vim'
alias v='vim'
alias :e='vim'
alias :q='exit'
alias q='exit'
alias :wq='exit'
alias p='python'
alias p2='python2'
alias p3='python3'
alias pe='pipenv'

# python calculator
pc() {
  python -c "print($1)"
}

# manage virtualenvs
venv() {
  # Deactivate any existing virtualenv
  if [ "$VIRTUAL_ENV" ]; then
    echo "Deactivating $VIRTUAL_ENV..."
    deactivate
  fi

  # By default, pick $(pwd) as the new env
  target=$(pwd)
  target=${target:1}

  # Use first argument instead if it exists
  if [ -n "$1" ]; then
    target="$1"
  fi

  # If the first argument is '-', just quit - ie, only deactivate
  if [ "$target" = "-" ]; then
    return
  fi

  # If the $target doesn't exist in the current dir, use ~/envs/$(target)
  if [ ! -f "${target}/bin/activate" ]; then
    target=~/envs/"$target"
  fi

  # Make the env if it doesn't exist
  if [ ! -f "${target}/bin/activate" ]; then
    echo "Creating ${target}"
    mkdir -p "$target"
    python3 -m venv "$target"
  fi

  # Activate the env
  echo "Activating ${target}"
  source "${target}/bin/activate"
}

# manage tmux sessions
t() {
  if [[ "$1" == *':'* ]]; then
    arr=("${(s/:/)1}")
    SSH=$arr[1]
    SESS=$arr[2]
  else
    SSH=
    SESS="$1"
  fi

  start=$(date +%s)

  if [ -z "$SESS" ]; then
    if [ -z "$SSH" ]; then
      tmux ls
    else
      ssh -t "$SSH" tmux ls
    fi

  elif [[ "$SESS" == '+'* ]]; then
    origin="${SESS: 1}"
    if [ -z "$SSH" ]; then
      num=$(tmux ls | grep "^$origin" | wc -l)
      num=$(($num + 1))
      tmux new -t $origin -s $origin$num
      echo "$origin $start $(date +%s)" >> ~/.tmux.hist
    else
      num=$(ssh -t "$SSH" tmux ls | grep "^$origin" | wc -l)
      num=$(($num + 1))
      ssh -t "$SSH" tmux new -t $origin -s $origin$num
      echo "$SSH:$origin $start $(date +%s)" >> ~/.tmux.hist
    fi

  else
    if [ -z "$SSH" ]; then
      if tmux attach -t "$SESS" &> /dev/null; then
      else
        tmux new -s "$SESS"
      fi
      echo "$SESS $start $(date +%s)" >> ~/.tmux.hist

    else
      if ssh -t "$SSH" "tmux attach -t '$SESS' &> /dev/null"; then
      else
        ssh -t "$SSH" tmux new -s "$SESS"
      fi
      echo "$SSH:$SESS $start $(date +%s)" >> ~/.tmux.hist

    fi
  fi
}

# manage docker-based workspaces
export DNS=1.1.1.1
d() {
  SESS="$1"
  mkdir -p ~/.workspaces/"$SESS"
  mkdir -p ~/.workspaces/.share

  if [ -z "$SESS" ]; then
    ls ~/.workspaces

  else
    shift
    exists=$(docker ps -aqf "name=$SESS")

    # create a container if it doesn't exist
    if [ -z "$exists" ]; then
      echo "Creating container..."
      exists=$(docker run \
          --dns $DNS \
          --env "http_proxy=$http_proxy" \
          --env "https_proxy=$https_proxy" \
          --env "no_proxy=$no_proxy" \
          --detach \
          --hostname "$SESS" \
          --interactive \
          --name "$SESS-workspace" \
          --rm \
          --tty \
          --volume /var/run/docker.sock:/var/run/docker.sock \
          --volume ~/.ssh/id_rsa.pub:/home/john/.ssh/id_rsa.pub \
          --volume ~/.ssh/id_rsa:/home/john/.ssh/id_rsa \
          --volume ~/.workspaces/"$SESS":/home/john/dev \
          --volume ~/.workspaces/.share:/home/john/shr \
          "$@" \
          scizzorz/arch)

      # need to add myself to whatever group owns /var/run/docker.sock inside
      # the container. this can't be done as part of the image because the
      # permissions on the socket are set by the *host* machine, so it varies
      # from host to host. eg, on my home machine, the docker group is gid 992,
      # but on my work machine, it's 995. inside the container, those are
      # (currently) mapped to kvm and audio respectively, while the docker
      # group is gid 977. moral of the story is that user permissions are
      # hard in docker images and that's why they usually just run as root, I
      # guess.
      echo "Fixing groups..."
      docker cp ~/dots/fix-groups.sh $exists:/home/john/dots/fix-groups.sh
      docker exec \
        $exists \
        /usr/bin/zsh /home/john/dots/fix-groups.sh
    fi

    echo "Entering container..."
    docker exec \
      --interactive \
      --tty \
      --user john \
      $exists \
      /usr/bin/zsh

  fi
}

# copy things to clipboard
x() {
  input="$@"
  if [ ! -t 0 ]; then
    input=/dev/stdin
  fi
  cat "$input" | xsel -b
}

# uses `thefuck` to fix previous command
fuck () {
  TF_PYTHONIOENCODING=$PYTHONIOENCODING;
  export TF_SHELL=zsh;
  export TF_ALIAS=fuck;
  TF_SHELL_ALIASES=$(alias);
  export TF_SHELL_ALIASES;
  TF_HISTORY="$(fc -ln -10)";
  export TF_HISTORY;
  export PYTHONIOENCODING=utf-8;
  TF_CMD=$(
      thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
  ) && eval $TF_CMD;
  unset TF_HISTORY;
  export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
  test -n "$TF_CMD" && print -s $TF_CMD
}

# zsh syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
  ZSH_HIGHLIGHT_STYLES[alias]=fg=none
  ZSH_HIGHLIGHT_STYLES[builtin]=fg=none
  ZSH_HIGHLIGHT_STYLES[function]=fg=none
  ZSH_HIGHLIGHT_STYLES[command]=fg=none
  ZSH_HIGHLIGHT_STYLES[precommand]=fg=none

  ZSH_HIGHLIGHT_STYLES[path]=fg=none
  ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=white
  ZSH_HIGHLIGHT_STYLES[path_approx]=fg=white
  ZSH_HIGHLIGHT_STYLES[globbing]=fg=cyan
fi

# $TERM is magic
export TERM=xterm-256color

# set up proxy variables in an untracked file
[ -f ~/.proxy.sh ] && source ~/.proxy.sh

# does Cargo still use this?
[ -f ~/.cargo/env ] && source ~/.cargo/env
