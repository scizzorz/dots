#!/bin/bash

function inst {
	echo "Installing $2 as $1..."
	if [ -e $1 ]; then
		#mv $1 $1.bak
		mv $1 $1.bak
	fi
	#ln -s $2 $1
	ln -s $2 $1
}

FROM=$(pwd)
TO=~
echo "Installing from $FROM to $TO"
inst $TO/.vimrc $FROM/vimrc
inst $TO/.bashrc $FROM/bashrc
inst $TO/.colordiffrc $FROM/colordiffrc
inst $TO/.dircolors $FROM/dircolors
inst $TO/.gitconfig $FROM/gitconfig
inst $TO/.tmux.conf $FROM/tmux.conf
inst $TO/.trkrc $FROM/trkrc
inst $TO/.vim $FROM/vim
inst $TO/.vimrc $FROM/vimrc
inst $TO/.pylintrc $FROM/pylintrc

echo "Installing $FROM/fonts/* as $TO/.fonts/*..."
if [ ! -e $TO/.fonts ]; then
	mkdir $TO/.fonts
fi
cp -rf $FROM/fonts/* $TO/.fonts/

echo "Installing $FROM/themes/* as $TO/.themes/*..."
if [ ! -e $TO/.themes ]; then
	mkdir $TO/.themes
fi
cp -rf $FROM/themes/* $TO/.themes/

echo "Use schemer.py to set gnome-terminal palette colors."
echo "Copy bashcolors.sh.example to ~/.bashcolors.sh and update the colors."
