#!/bin/bash
# Script to setup vim

echo "Setting up vim ..."

CURRENT_DIR=$(pwd) 

# Backup old files
mv -v ~/.vim ~/.vim.old
mv -v ~/.vimrc ~/.vimrc.old

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
