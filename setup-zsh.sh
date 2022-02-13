#!/bin/bash

echo "Setting up zsh ..."

CURRENT_DIR=$(pwd)

# Backup old files
if [ -f ~/.aliases ]; then
    mv -v ~/.aliases ~/.aliases.old
fi

if [ -f ~/.zsh_env ]; then
    mv -v ~/.zsh_env ~/.zsh_env.old
fi

# Link new files
ln -sv $CURRENT_DIR/zsh/aliases ~/.aliases
ln -sv $CURRENT_DIR/zsh/zsh_env.$(hostname) ~/.zsh_env

if [ -f ~/.bashrc ]; then
    cp -v ~/.bashrc ~/.bashrc.old
    echo "[ -f ~/.zsh_env ] && source ~/.zsh_env" >> ~/.bashrc
fi

if [ -f ~/.zshrc ]; then
    cp -v ~/.zshrc ~/.zshrc.old
    echo "[ -f ~/.zsh_env ] && source ~/.zsh_env" >> ~/.zshrc
fi

echo "Done!"
