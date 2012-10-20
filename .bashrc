# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# update path
export PATH=$PATH:~/bin:~/scripts:./:~/android/tools/:~/android/platform-tools/:/flex/bin:/depot_tools/:/arduino/:/dart/bin/

# aliases
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
hcolor="15"
if [ `whoami` = root ]; then
	ucolor="8"
else
	ucolor=$hcolor
fi
wcolor="11"
gitcolor="8"

# prompt!
W=$(echo $PWD | sed 's!'$HOME'!~!g')
PROMPT_COMMAND='echo -ne "\033]0;${USER} ${HOSTNAME}: ${W}\007"'
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
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
