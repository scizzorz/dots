#!/bin/sh

export HOME=/home/$ME
chown -R $ME:$ME $HOME/dev

sudo -E -u $ME "$@"
