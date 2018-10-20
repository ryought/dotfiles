#!/bin/sh
cd ~

# git clone
git clone https://github.com/ryought/dotfiles.git .dotfiles
cd .dotfiles

# install and link
make
