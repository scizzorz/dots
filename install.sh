#!/bin/sh

inst() {
	echo "Installing $2 as $1..."
	if [ -e $1 ]; then
		if [ -h $1 ]; then
			rm $1 # remove existing symbolic links
		else
			mv $1 $1.bak # backup existing files
		fi
	fi
	ln -s $2 $1 # symlink
}

FROM=$(pwd)
TO=~

echo "Initializing git submodules..."
git submodule init
git submodule update

echo "Installing from $FROM to $TO"
inst $TO/.xinitrc $FROM/xinitrc
inst $TO/.vimrc $FROM/vimrc
inst $TO/.zshrc $FROM/zshrc
inst $TO/.dircolors $FROM/dircolors
inst $TO/.gitconfig $FROM/gitconfig
inst $TO/.tmux.conf $FROM/tmux.conf
inst $TO/.vim $FROM/vim
inst $TO/.vimrc $FROM/vimrc
inst $TO/.pylintrc $FROM/pylintrc
inst $TO/.conkyrc $FROM/conkyrc
inst $TO/.gtk-bookmarks $FROM/gtk-bookmarks
inst $TO/.xmodmap $FROM/xmodmap
inst $TO/.Xdefaults $FROM/Xdefaults

echo "Installing $FROM/fonts/* as $TO/.fonts/*..."
mkdir -p $TO/.fonts
cp -rf $FROM/fonts/* $TO/.fonts/

echo "Installing $FROM/themes/* as $TO/.themes/*..."
mkdir -p $TO/.themes
cp -rf $FROM/themes/* $TO/.themes/

mkdir -p $TO/.config/openbox
inst $TO/.config/openbox/rc.xml $FROM/openbox-rc.xml

mkdir -p $TO/.config/alacritty
inst $TO/.config/alacritty/alacritty.yml $FROM/alacritty.yml

mkdir -p $TO/.config/tint2
inst $TO/.config/tint2/tint2rc $FROM/tint2rc
