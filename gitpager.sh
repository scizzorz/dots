#!/bin/bash

stdin=$(cat /dev/stdin)
lines=$(echo "$stdin" | wc -l)
LINES=$(tput lines)

if [ "$lines" -lt "$LINES" ] ; then
	echo "$stdin"
else
	echo "$stdin" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | /bin/bash -c "vim -c 'set ft=mygit' -S ~/dots/vimp.rc </dev/tty <(col -b)"
fi
