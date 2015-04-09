#!/bin/bash

function do_ln()
{
	if [[ -f $HOME/.$1 ]]; then
		mv $HOME/.$1 $HOME/.$1.old
	fi
	ln -s $HOME/.dotfiles/$1 $HOME/.$1
}

# create the symlink
do_ln aliases
do_ln gitconfig
do_ln gitignore_global
do_ln irssi
do_ln ls_colors
do_ln tmux
do_ln tmux.config
do_ln vim
do_ln vimrc
do_ln zsh
do_ln zshrc

# get submodule
cd $HOME/.dotfiles

git submodule init
git submodule update

if [[ -n "$1" ]] && [[ "$1" = 42 ]]; then
	cd $HOME
	git clone git@github.com:Geam/libft.git libft
	git clone git@github.com:Geam/scripts.git scripts
	ln -s /nfs/sgoinfre
	brew update
	source $HOME/.zshrc
	brew install htop tig
fi
