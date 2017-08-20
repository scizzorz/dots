#!/bin/sh

#i3lock -n -d -c 2e3338
sleep 0.3
DISPLAY=:0.0 xset dpms force off &> /dev/null
echo -en '\x3\x5\xC\x24\x0\x78\x0\x2\x4' > /dev/ttyACM0
