DOTFILES := $(shell pwd)

.PHONY: all
all: submodule

.PHONY: install
install: symlink asdf brew git peco tmux mas masapps

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
ifdef $(shell hash brew)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@echo $@ already installed
endif

.PHONY: git
git: brew
	brew install git

.PHONY: peco
peco: brew
	brew install peco

.PHONY: tpm
tpm:
	$(DOTFILES)/etc/tmux/plugins/tpm/bin/install_plugins

.PHONY: tmux
tmux: brew tpm
	brew install tmux
	brew install ricty

.PHONY: mas
mas: brew
	brew install mas

.PHONY: masinstall
masapps: mas
	cat etc/maslist | awk '{print $$1}' | xargs -n1 mas install

etc/maslist:
	mas list | awk '{NF=NF-1}1' | grep -vxFf etc/masignore > $@
