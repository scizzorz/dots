#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#export LANG=en_US.UTF-8
#export LC_CTYPE=$LANG

#~/dev/ckb/bin/ckb --background
xmodmap ~/.xmodmap
sh ~/.fehbg

tint2 &
exec openbox
