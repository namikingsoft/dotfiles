DOTFILES := $(shell pwd)

.PHONY: all
all: submodule

.PHONY: install
install: symlink tpm asdf brew

.PHONY: submodule
submodule:
	git submodule init
	git submodule update
	ln -fsn ${DOTFILES}/vendor/gitmodules/tpm ${DOTFILES}/etc/tmux/plugins/tpm

.PHONY: symlink
symlink:
	ln -fs $(DOTFILES)/etc/zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/etc/zshrc ${HOME}/.zshrc
	ln -fsn $(DOTFILES)/etc/tmux ${HOME}/.tmux
	ln -fs $(DOTFILES)/etc/tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/etc/tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fs $(DOTFILES)/etc/vimrc ${HOME}/.vimrc
	ln -fs $(DOTFILES)/etc/gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/etc/gitconfig.ignore ${HOME}/.gitconfig.ignore
	ln -fs $(DOTFILES)/etc/asdfrc ${HOME}/.asdfrc
	-yes n | cp -i $(DOTFILES)/etc/zshrc.local ${HOME}/.zshrc.local
	-yes n | cp -i $(DOTFILES)/etc/gitconfig.local ${HOME}/.gitconfig.local
	touch ${HOME}/.gitmessage.local

.PHONY: asdf
asdf:
	-git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	. ${HOME}/.asdf/asdf.sh
	-asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	-asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
	-asdf plugin add kubectl https://github.com/Banno/asdf-kubectl.git
	-asdf plugin add minikube https://github.com/alvarobp/asdf-minikube.git

.PHONY: brew
brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: tpm
tpm:
	$(DOTFILES)/etc/tmux/plugins/tpm/bin/install_plugins

.PHONY: lpm
lpm:
	wget -O /tmp/lpm http://www.kasahara.ws/lpm/lpm
	chmod +x /tmp/lpm
	/tmp/lpm --local local initlocaldir
