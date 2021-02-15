#!/bin/bash

echo "Setting up bash ..."

append_aliases()
{
cat >> $1 <<EOF
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi
EOF
}

CURRENT_DIR=$(pwd)

# Backup old files
if [ -f ~/.aliases ]; then
    mv -v ~/.aliases ~/.aliases.old
fi

# Link new files
ln -sv $CURRENT_DIR/bash/aliases ~/.aliases

if [ -f ~/.bashrc ]; then
    cp -v ~/.bashrc ~/.bashrc.old
    append_aliases ~/.bashrc
fi

if [ -f ~/.zshrc ]; then
    cp -v ~/.zshrc ~/.zshrc.old
    append_aliases ~/.zshrc
fi

echo "Done!"
