#!/bin/bash

echo "Setting up tmux ..."

CURRENT_DIR=$(pwd)

TMUX_CONFIG=.tmux.conf

# Backup old files
if [ -f ~/.tmux.conf ]; then
    mv -v ~/.tmux.conf ~/.tmux.conf.old
fi

# Link new files
ln -sv $CURRENT_DIR/tmux/.tmux.conf ~/.tmux.conf

echo "Done!"
