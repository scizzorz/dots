# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# use vim as the man pager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'noremap q <Esc>:q<Return>' -\""
export EDITOR="/usr/bin/vim"

# update path
export PATH=~/bin:~/scripts:./:~/android/tools/:~/android/platform-tools/:/flex/bin:/depot_tools/:/arduino/:/dart/bin/:$PATH

# for arduino-mk
export ARDMK_DIR=/usr/local
export ARDUINO_DIR=/usr/share/arduino
export AVR_TOOLS_DIR=/usr
export AVRDUDE_CONF=/usr/share/arduino/hardware/tools/avrdude.conf

# aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# don't put blank lines in the history and control size
HISTCONTROL=ignorespace
HISTSIZE=9999
HISTFILESIZE=9999
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# derp
parse_git_branch_shell() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
parse_git_status() {
	if [ $(git status --porcelain 2> /dev/null | wc -l) -gt "0" ]; then
		echo "*"
	fi
}
parse_git_ahead() {
	numAhead=$(git status -b --porcelain 2> /dev/null | grep -oe 'ahead [0-9]\+' | grep --color=none -oe '[0-9]\+')
	if [ "$numAhead" ]; then
		echo " +$numAhead"
	fi
}
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

parse_clk_status_color() {
	C="none"
	if [ -x ~/.clk.py ]; then
		C=$(~/.clk.py status)
	fi
	if [ $C == "none" ]; then
		tput setaf $clknocolor
	fi
	if [ $C == "in" ]; then
		tput setaf $clkincolor
	fi
	if [ $C == "out" ]; then
		tput setaf $clkoutcolor
	fi
}

# set the colors for the prompt
if [ -f ./.bashcolors.sh ]; then
	. .bashcolors.sh

	# prompt!
	case "$TERM" in
	xterm*|rxvt*)
		# some terminals need this I guess... lame.
		export TERM=xterm-256color

		W=$(echo $PWD | sed 's!'$HOME'!~!g')

		PROMPT_COMMAND='echo -ne "\033]0;${USER} ${HOSTNAME} ${W}\007"'
		PS1="\[$(tput setaf 2)\]\! \[$(tput setaf $ucolor)\]\u \[$(tput setaf $hcolor)\]\h \[$(tput setaf $wcolor)\]\w\[$(tput setaf $gitcolor)\]\$(parse_git_branch_shell)\$(parse_git_status)\$(parse_git_ahead)\[\$(parse_clk_status_color)\] \\$\[$(tput sgr0)\] "
		PS2="\[$(tput setaf $ucolor)\]>\[$(tput sgr0)\]"
		;;
	*)
		PS1="\[$(tput setaf 7)\]\! \[$(tput setaf $ucolor_)\]\u \[$(tput setaf $hcolor_)\]\h \[$(tput setaf $wcolor_)\]\w\[$(tput setaf $gitcolor_)\]\$(parse_git_branch_shell)\$(parse_git_status)\$(parse_git_ahead)\[$(tput setaf $wcolor_)\] \\$\[$(tput sgr0)\] "
		PS2="\[$(tput setaf $ucolor_)\]>\[$(tput sgr0)\]"
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

if [ -x ~/.motd ]; then
	~/.motd
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
