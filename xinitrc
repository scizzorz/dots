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
#xrandr --output VGA-1 --auto --output DVI-I-1 --left-of VGA-1
#xrandr --output HDMI-1 --auto

# DVI-D-0    HDMI-0    DVI-I-1
# DVI-D-0  DVI-I-1 HDMI-0
RIGHT="DVI-D-0"
CENTER="HDMI-0"
LEFT="DVI-I-1"
xrandr --output $CENTER --auto --output $LEFT --left-of $CENTER --output $RIGHT --right-of $CENTER
#xrandr --output HDMI-0 --mode 1920x1080


#~/dev/ckb/bin/ckb --background
xmodmap ~/.xmodmap
sh ~/.fehbg

tint2 &
urxvt &
exec openbox
