#!/bin/bash

# vim 
git submodule init
git submodule update

cp .vimrc ~/
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/plugin

cp -rf vundle ~/.vim/bundle/vundle 
cp a.vim/plugin/a.vim ~/.vim/plugin/
cp wmgraphviz.vim/ftplugin/dot.vim ~/.vim/plugin
echo "next: install vim YCM"

# git 
cp .gitconfig ~/

# screen  
cp .screenrc ~/


# fcitx
cp .xprofile ~/

# alsa
cp .asoundrc ~/


