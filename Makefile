# Var
DOTFILES := $(shell pwd)

# Makefile
all: chmod neobundle
install: symlink
chmod:
	chmod +x bin/*
neobundle:
	rm -Rf .vim/bundle/neobundle.vim
	git clone https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim
	vim +NeoBundleInstall +qall
	vim +NeoBundleClean +qall
symlink:
	mkdir -p ${HOME}/bin
	ln -fs ${DOTFILES}/bin/php-xdebug ${HOME}/bin/php-xdebug
	ln -fs $(DOTFILES)/.zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/.zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/.vim ${HOME}/.vim
	ln -fs $(DOTFILES)/.vimrc ${HOME}/.vimrc
