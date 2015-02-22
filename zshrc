[ -z "$PS1" ] && return
[ $TERM != "screen" ] && hash tmux &>/dev/null && exec tmux

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
		echo $(basename $VIRTUAL_ENV)" "
	fi
}

parse_git_dir() {
	local GIT_BRANCH="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \1/')"
	local GIT_COMMIT="$(git log -1 --format="/%h" 2>/dev/null)"
	local GIT_ALL="$(git status --porcelain 2>/dev/null | wc -l)"
	local GIT_MOD="$(git status --porcelain -uno 2>/dev/null | wc -l )"
	local GIT_UNT="$(($GIT_ALL-$GIT_MOD))"
	echo -n "$GIT_BRANCH$GIT_COMMIT"
	if [ $GIT_UNT -gt "0" ]; then
		echo -n " ?$GIT_UNT"
	fi
	if [ $GIT_MOD -gt "0" ]; then
		echo -n " !$GIT_MOD"
	fi
}

# set up prompt
export VIRTUAL_ENV_DISABLE_PROMPT=true
setopt PROMPT_SUBST
setopt PROMPT_PERCENT
export PROMPT='$fg_bold[black]$(parse_venv)$fg_no_bold[magenta]%~$fg_bold[black]$(parse_git_dir)%(1j, %%%j,) %(?,$fg_no_bold[green],$fg_no_bold[red])» $reset_color%b'

# set up default editor
export EDITOR=vim

# for Rust
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# for Ruby
export PATH=~/.gem/ruby/2.1.0/bin:$PATH

# $PATH nonsense
export PATH=./:$PATH
export PATH=~/bin:$PATH
export PATH=~/scripts:$PATH

# set up alises
alias please='sudo $(history -p !-1)'

venv() {
	if [ -z "$@" ]; then
		echo "Deactivating..."
		deactivate
	elif [ -f "$1/bin/activate" ]; then
		echo "Activating $1..."
		source "$1/bin/activate"
	else
		echo "Creating $1..."
		virtualenv "$@"
		echo "Activating $1"...
		source "$1/bin/activate"
	fi
}
