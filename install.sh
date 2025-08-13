#!/bin/sh

inst() {
  echo "Installing $2 as $1..."
  if [ -e $1 ]; then
    if [ -h $1 ]; then
      echo "  Removing symlink $1"
      rm $1 # remove existing symbolic links
    else
      echo "  Backing up file $1"
      mv $1 $1.bak # backup existing files
    fi
  fi
  ln -s $2 $1 # symlink
}

FROM=$(pwd)
TO=~

echo "Initializing git submodules..."
git submodule update --init --recursive

mkdir -p $TO/.config
mkdir -p $TO/.local/share/nvim/site/autoload

echo "Installing from $FROM to $TO"
inst $TO/.xinitrc $FROM/xinitrc
inst $TO/.zshrc $FROM/zshrc
inst $TO/.gitconfig $FROM/gitconfig
inst $TO/.tmux.conf $FROM/tmux.conf
inst $TO/.gtk-bookmarks $FROM/gtk-bookmarks
inst $TO/.xmodmap $FROM/xmodmap
inst $TO/.config/nvim $FROM/nvim
inst $TO/.local/share/nvim/site/autoload/plug.vim $FROM/nvim/plug.vim

echo "Installing $FROM/fonts/* as $TO/.fonts/*..."
mkdir -p $TO/.fonts
cp -rf $FROM/fonts/* $TO/.fonts/

echo "Installing $FROM/themes/* as $TO/.themes/*..."
mkdir -p $TO/.themes
cp -rf $FROM/themes/* $TO/.themes/

mkdir -p $TO/.config/alacritty
bin/set-alacritty-theme.sh dark
inst $TO/.config/alacritty/alacritty.yml $FROM/alacritty.yml

bin/set-prompt-theme.sh default

mkdir -p $TO/.config/tint2
inst $TO/.config/tint2/tint2rc $FROM/tint2rc
