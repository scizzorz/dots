#!/bin/bash

if ssh -o ConnectTimeout=5 $1 pwd &> /dev/null; then
	echo 'up'
else
	echo '${color1}down${color}'
fi
