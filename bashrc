# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# this makes tmux play nicely with gnome-terminal
if [ $TERM == 'xterm' ]; then
	export TERM=xterm-256color
fi
[ $TERM != "screen" ] && exec tmux

# use vim as the man pager
export MANPAGER='/bin/bash -c "vim -c \"silent! set ft=man ts=8 fdc=0 cc=0 nomod nolist nonu nornu noma nofen\" -c \"noremap q <Esc>:q!<Return>\" -c \"noremap j <C-e>\" -c \"noremap k <C-y>\"</dev/tty <(col -b)"'
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
alias please='sudo $(history -p !-1)'
alias t='~/dev/trk/trk.py'
alias tl='~/dev/trk/trk.py --file=todo'
alias c='~/dev/colors/colors.py'

# don't put blank lines in the history and control size
HISTCONTROL=ignorespace:ignoredups
HISTSIZE=9999
HISTFILESIZE=9999
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# derp
function vimp {
	/bin/bash -c "vim -c 'silent! set ft=$1 ts=8 fdc=0 cc=0 nomod nolist nonu nornu noma nofen' -c 'noremap q <Esc>:q!<Return>' -c 'noremap j <C-e>' -c 'noremap k <C-y>'</dev/tty <(col -b)"
}

function parse_git_branch_shell {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/' -e 's/master/-/'
}
function parse_git_status {
	all=$(git status --porcelain 2> /dev/null | wc -l)
	modified=$(git status --porcelain -uno 2> /dev/null | wc -l)
	untracked=$(($all-$modified))
	numAhead=$(git rev-list origin..HEAD 2> /dev/null | wc -l)

	# this technically isn't "git" status, but it's useful stuff
	numJobs=$(jobs | wc -l)

	if [ $modified -gt "0" ]; then
		echo -n " !$modified"
	fi
	if [ $untracked -gt "0" ]; then
		echo -n " ?$untracked"
	fi
	if [ $numAhead -gt "0" ]; then
		echo -n " +$numAhead"
	fi
	if [ $numJobs -gt "0" ]; then
		echo -n " %$numJobs"
	fi
}
function parse_local_trk_status {
	if [ -f todo ]; then
		echo -n "+"
	fi
}

# set the colors for the prompt
if [ -f ~/.bashcolors.sh ]; then
	# this file is not included in my dots repo!
	# it exports some colors used in the PS1 and PS2 variables
	# it's not included so that each host can have its own
	# unique colors without possibly causing any git conflicts
	. ~/.bashcolors.sh

	# prompt!
	case "$TERM" in
	xterm*|screen*)
		# makes my colors play nicely with stuff
		restoreTerm="$TERM"
		export TERM=xterm-256color

		W=$(echo $PWD | sed 's!'$HOME'!~!g')

		HOSTCOLOR=$(tput setaf $hcolor)
		GITCOLOR=$(tput setaf $gitcolor)
		PROMPTCOLOR=$(tput setaf $pcolor)
		RESET=$(tput sgr0)

		PROMPT_COMMAND='history -a; history -n; echo -ne "\033]0;${USER} ${HOSTNAME} ${W}\007"'
		PS1="\[$HOSTCOLOR\]\w\[$PROMPTCOLOR\]\$(parse_local_trk_status)\[$GITCOLOR\]\$(parse_git_branch_shell)\$(parse_git_status)\[$PROMPTCOLOR\] »\[$RESET\] "
		PS2="\[$HOSTCOLOR\]...\[$RESET\] "

		# resture the TERM to what it was
		export TERM="$restoreTerm"
		;;
	*)
		LINECOLOR=$(tput setaf 7)
		USERCOLOR=$(tput setaf $ucolor_)
		HOSTCOLOR=$(tput setaf $hcolor_)
		WDIRCOLOR=$(tput setaf $wcolor_)
		GITCOLOR=$(tput setaf $gitcolor_)
		RESET=$(tput sgr0)

		PS1="\[$LINECOLOR\]\! \[$USERCOLOR\]\u \[$HOSTCOLOR\]\h \[$WDIRCOLOR\]\w\[$GITCOLOR\]\$(parse_git_branch_shell)\$(parse_git_status)\$(parse_git_ahead)\[$WDIRCOLOR\] \\$\[$RESET\] "
		PS2="\[$USERCOLOR\]>\[$RESET\]"
		;;
	esac

fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -p --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
	eval $( dircolors -b ~/.dircolors )
fi

if [ -x ~/.motd ]; then
	~/.motd
fi

if [ -x ~/dev/trk/trk.py ]; then
	~/dev/trk/trk.py
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
