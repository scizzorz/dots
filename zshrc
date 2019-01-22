[ -z "$PS1" ] && return
#[ $TERM != "screen" ] && [ $TERM != "linux" ] && hash tmux &>/dev/null && exec tmux

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/john/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Load colors
autoload -U colors && colors

parse_venv() {
	if [ "$VIRTUAL_ENV" ]; then
		echo " @"
	fi
}

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
[ -f ~/.prompt.sh ] && source ~/.prompt.sh

export VIRTUAL_ENV_DISABLE_PROMPT=true
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

# for Rust
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# for Ruby
export PATH=~/.gem/ruby/2.1.0/bin:$PATH
export PATH=~/.gem/ruby/2.2.0/bin:$PATH

# for Android
export PATH=/opt/android-sdk/tools:$PATH
export PATH=/opt/android-sdk/platform-tools:$PATH
export PATH=/opt/android-sdk/build-tools:$PATH

# $PATH nonsense
export PATH=./:$PATH
export PATH=~/bin:$PATH
export PATH=~/scripts:$PATH
export PATH=~/pico-8:$PATH

# for SerPix
export PYTHONPATH=~/dev/arduino/serpix:$PYTHONPATH

# For FZF
export FZF_DEFAULT_COMMAND='ag -g ""'

# For Wine
export WINEARCH=win32

# set up alises
alias please='sudo $(history -p !-1)'
alias ls='ls -F --color=auto'
alias grep='grep -I'
alias ag='ag --color-match "30;31"'
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

# manage tmux
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

# copy things to clipboard
x() {
  input="$@"
  if [ ! -t 0 ]; then
    input=/dev/stdin
  fi
  cat "$input" | xsel -b
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

export TERM=xterm-256color

# added by travis gem
[ -f /home/john/.travis/travis.sh ] && source /home/john/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.proxy.sh ] && source ~/.proxy.sh
[ -f ~/.cargo/env ] && source ~/.cargo/env
