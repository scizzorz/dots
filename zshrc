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
	local GIT_COMMIT="$(git log -1 --format="%h" 2>/dev/null)"
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
export VIRTUAL_ENV_DISABLE_PROMPT=true
setopt PROMPT_SUBST
setopt PROMPT_PERCENT
export PROMPT='%{$fg_bold[black]%}%{$fg_no_bold[magenta]%}%~%{$fg_bold[black]%}$(parse_git_dir)$(parse_venv)%(1j, %%,) %(?,%{$fg_no_bold[green]%},%{$fg_no_bold[red]%})» %{$reset_color%}%b'

# set up window titles
function precmd {
  print -Pn "\e]0;%m %~\a"
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

# for SerPix
export PYTHONPATH=~/dev/arduino/serpix:$PYTHONPATH

# set up alises
alias please='sudo $(history -p !-1)'
alias ls='ls -F --color=auto'
alias :e='vim'
alias :q='exit'
alias :wq='exit'

# manage virtualenvs
venv() {
	if [ -z "$@" ]; then
		if [ "$VIRTUAL_ENV" ]; then
			echo "$VIRTUAL_ENV"
		else
			echo "Not in a virtualenv"
		fi
	else
		if [ "$VIRTUAL_ENV" ]; then
			echo "Deactivating $VIRTUAL_ENV..."
			deactivate
		fi

		if [ -f "$1/bin/activate" ]; then
			echo "Activating $1..."
			source "$1/bin/activate"
		elif [ "$1" != "-" ]; then
			echo "Creating $1..."
			python3 -m venv "$@"
			echo "Activating $1"...
			source "$1/bin/activate"
		fi
	fi
}

# manage tmux
t() {
  if [ -z "$1" ]; then
    tmux ls
  elif [[ "$1" == '+'* ]]; then
    origin="${1: 1}"
    num=$(tmux ls | grep "^$origin" | wc -l)
    num=$(($num + 1))
    tmux new -t $origin -s $origin$num
  elif tmux attach -t "$1" &> /dev/null; then
  else
    tmux new -s "$1";
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

export TERM=xterm

# added by travis gem
[ -f /home/john/.travis/travis.sh ] && source /home/john/.travis/travis.sh
