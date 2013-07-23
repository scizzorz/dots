# vim:ft=sh

export hcolor="5"
export gitcolor="7"

if [ `whoami` = root ]; then
	export pcolor="1"
else
	export pcolor="2"
fi
