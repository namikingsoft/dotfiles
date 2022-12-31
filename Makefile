# Var
DOTFILES := $(shell pwd)

# Makefile
all: submodule
install: symlink dein tpm
submodule:
	git submodule init
	git submodule update
	ln -fsn ${DOTFILES}/vendor/gitmodules/tpm ${DOTFILES}/etc/tmux/plugins/tpm
symlink:
	ln -fs $(DOTFILES)/etc/zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/etc/zshrc ${HOME}/.zshrc
	ln -fsn $(DOTFILES)/etc/tmux ${HOME}/.tmux
	ln -fs $(DOTFILES)/etc/tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/etc/tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/etc/vim ${HOME}/.vim
	ln -fs $(DOTFILES)/etc/vimrc ${HOME}/.vimrc
	ln -fs $(DOTFILES)/etc/gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/etc/gitconfig.ignore ${HOME}/.gitconfig.ignore
	ln -fs $(DOTFILES)/etc/asdfrc ${HOME}/.asdfrc
	-yes n | cp -i $(DOTFILES)/etc/zshrc.local ${HOME}/.zshrc.local
	-yes n | cp -i $(DOTFILES)/etc/gitconfig.local ${HOME}/.gitconfig.local
	touch ${HOME}/.gitmessage.local
dein:
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh
	sh /tmp/dein-installer.sh ~/.cache/dein
	-yes y | vim -N -u NONE -i NONE -V1 -e -s --cmd "source ~/.vimrc" --cmd "call dein#update()" --cmd qall!
tpm:
	$(DOTFILES)/etc/tmux/plugins/tpm/bin/install_plugins
lpm:
	wget -O /tmp/lpm http://www.kasahara.ws/lpm/lpm
	chmod +x /tmp/lpm
	/tmp/lpm --local local initlocaldir
