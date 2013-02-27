#!/bin/bash

stdin=$(cat /dev/stdin)
lines=$(echo "$stdin" | wc -l)
LINES=$(tput lines)

if [ "$lines" -lt "$LINES" ] ; then
	echo "$stdin"
else
	echo "$stdin" | /bin/sh -c "col -b | vim -c 'set ft=mygit ts=8 nomod nolist nonu noma' -c 'noremap q <Esc>:q<Return>' -"
fi
