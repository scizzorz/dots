# vim:ft=sh

export hcolor="13"
export dcolor="5"
export gitcolor="8"
export host=""

if [ `whoami` = root ]; then
	export pcolor="1"
else
	export pcolor="2"
fi
