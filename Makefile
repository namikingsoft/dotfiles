# Var
DOTFILES := $(shell pwd)

# Makefile
all: zsh vim tmux
zsh:
	ln -fs $(DOTFILES)/.zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/.zshenv ${HOME}/.zshenv
tmux:
	ln -fs $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
vim:
	ln -fsn $(DOTFILES)/.vim ${HOME}/.vim
	ln -fs $(DOTFILES)/.vimrc ${HOME}/.vimrc
