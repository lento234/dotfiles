#!/bin/bash

echo "Setting up tmux ..."
CURRENT_DIR=$(pwd)

# Cloning tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Backup old files
if [ -f ~/.tmux.conf ]; then
    mv -v ~/.tmux.conf ~/.tmux.conf.old
fi

# Link new files
ln -sv $CURRENT_DIR/tmux/.tmux.conf ~/.tmux.conf

echo "Done!"
