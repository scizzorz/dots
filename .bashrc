# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# some terminals need this I guess... lame.
export TERM=xterm-256color

# update path
export PATH=$PATH:~/bin:~/scripts:./:~/android/tools/:~/android/platform-tools/:/flex/bin:/depot_tools/:/arduino/:/dart/bin/

# aliases
alias t='/home/john/projects/trk/trk.py'
alias trk='/home/john/projects/trk/trk.py'
alias su='sudo -s'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# don't put duplicate lines in the history and control size
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# derp
parse_git_branch_shell() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# set the colors for the prompt
if [ -f ./.bashcolors.sh ]; then
	. .bashcolors.sh

	# prompt!
	W=$(echo $PWD | sed 's!'$HOME'!~!g')
	PROMPT_COMMAND='echo -ne "\033]0;${USER} ${HOSTNAME} ${W}\007"'
	PS1="\[$(tput setaf $ucolor)\]\u \[$(tput setaf $hcolor)\]\h \[$(tput setaf $wcolor)\]\w\[$(tput setaf $gitcolor)\]\$(parse_git_branch_shell)\[$(tput setaf $wcolor)\] \\$\[$(tput sgr0)\] "
	PS2="\[$(tput setaf $ucolor)\]>\[$(tput sgr0)\]"
	case "$TERM" in
	xterm*|rxvt*)
		PS1="\[$(tput setaf $ucolor)\]\u \[$(tput setaf $hcolor)\]\h \[$(tput setaf $wcolor)\]\w\[$(tput setaf $gitcolor)\]\$(parse_git_branch_shell)\[$(tput setaf $wcolor)\] \\$\[$(tput sgr0)\] "
		PS2="\[$(tput setaf $ucolor)\]>\[$(tput sgr0)\]"
		;;
	*)
		;;
	esac

fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
	eval $( dircolors -b ~/.dircolors )
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
