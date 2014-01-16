# Var
DOTFILES := $(shell pwd)

# Makefile
all: submodule
install: symlink neobundle
submodule:
	git submodule init
	git submodule update
	ln -fsn ${DOTFILES}/vendor/neobundle.vim ${DOTFILES}/.vim/bundle/neobundle.vim
symlink:
	mkdir -p ${HOME}/bin
	ln -fs ${DOTFILES}/bin/php-xdebug ${HOME}/bin/php-xdebug
	ln -fs $(DOTFILES)/.zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/.zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/.vim ${HOME}/.vim
	ln -fs $(DOTFILES)/.vimrc ${HOME}/.vimrc
neobundle:
	vim +NeoBundleInstall +qall
	vim +NeoBundleClean +qall
