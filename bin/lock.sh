#!/bin/sh

i3lock -n -d -c 2e3338 &
sleep 0.5
DISPLAY=:0.0 xset dpms force off &> /dev/null
