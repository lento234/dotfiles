#!/bin/bash
# Script to setup vim

echo "Setting up vim ..."

CURRENT_DIR=$(pwd) 

# Backup old files
if [ -f ~/.vim ]; then
    mv -v ~/.vim ~/.vim.old
fi
if [ -f ~/.vimrc ]; then
    mv -v ~/.vimrc ~/.vimrc.old
fi

# Link new files
ln -sv $CURRENT_DIR/vim/.vim ~/.vim
ln -sv $CURRENT_DIR/vim/.vimrc ~/.vimrc

# Install vundle and other submodules
git submodule init
git submodule update

# Install all plugins
vim +PluginInstall +qall

# Cleanup
unset CURRENT_DIR

echo "Done!"
