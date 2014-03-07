# Var
DOTFILES := $(shell pwd)

# Makefile
all: submodule
install: symlink neobundle
submodule:
	git submodule init
	git submodule update
	ln -fsn ${DOTFILES}/vendor/gitmodules/neobundle.vim ${DOTFILES}/.vim/bundle/neobundle.vim
symlink:
	chmod -R 755 ${DITFILES}/bin
	ln -fs $(DOTFILES)/.zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/.zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/.vim ${HOME}/.vim
	ln -fs $(DOTFILES)/.vimrc ${HOME}/.vimrc
	ln -fs $(DOTFILES)/.gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/.gitconfig.ignore ${HOME}/.gitconfig.ignore
	-yes n | cp -i $(DOTFILES)/.gitconfig.local ${HOME}/.gitconfig.local
neobundle:
	vim +NeoBundleInstall +qall
	vim +NeoBundleClean +qall
lpm:
	wget -O /tmp/lpm http://www.kasahara.ws/lpm/lpm
	chmod +x /tmp/lpm
	/tmp/lpm --local local initlocaldir
