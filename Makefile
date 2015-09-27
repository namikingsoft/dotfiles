# Var
DOTFILES := $(shell pwd)

# Makefile
all: submodule
install: symlink neobundle
submodule:
	git submodule init
	git submodule update
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	ln -fsn ${DOTFILES}/vendor/gitmodules/neobundle.vim ${DOTFILES}/etc/vim/bundle/neobundle.vim
symlink:
	ln -fs $(DOTFILES)/etc/zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/etc/zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/etc/tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/etc/tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/etc/vim ${HOME}/.vim
	ln -fs $(DOTFILES)/etc/vimrc ${HOME}/.vimrc
	ln -fs $(DOTFILES)/etc/gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/etc/gitconfig.ignore ${HOME}/.gitconfig.ignore
	-yes n | cp -i $(DOTFILES)/etc/zshrc.local ${HOME}/.zshrc.local
	-yes n | cp -i $(DOTFILES)/etc/gitconfig.local ${HOME}/.gitconfig.local
neobundle:
	vim +NeoBundleInstall +qall
	vim +NeoBundleClean +qall
lpm:
	wget -O /tmp/lpm http://www.kasahara.ws/lpm/lpm
	chmod +x /tmp/lpm
	/tmp/lpm --local local initlocaldir
