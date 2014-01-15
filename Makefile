# Var
DOTFILES := $(shell pwd)

# Makefile
all: neobundle_checkout
install: make_symlink neobundle_install
neobundle_checkout:
	rm -Rf .vim/bundle/neobundle.vim
	git clone https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim
make_symlink:
	mkdir -p ${HOME}/bin
	ln -fs ${DOTFILES}/bin/php-xdebug ${HOME}/bin/php-xdebug
	ln -fs $(DOTFILES)/.zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/.zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/.vim ${HOME}/.vim
	ln -fs $(DOTFILES)/.vimrc ${HOME}/.vimrc
neobundle_install:
	vim +NeoBundleInstall +qall
	vim +NeoBundleClean +qall
