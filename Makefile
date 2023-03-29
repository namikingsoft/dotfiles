DOTFILES := $(shell pwd)

.PHONY: all
all: submodule

.PHONY: install
install: symlink asdf brew git peco tmux mas masapps cask

.PHONY: submodule
submodule:
	git submodule init
	git submodule update
	ln -fsn ${DOTFILES}/vendor/gitmodules/tpm ${DOTFILES}/etc/tmux/plugins/tpm

.PHONY: symlink
symlink: \
	${HOME}/.zshrc \
	${HOME}/.gitconfig \
	${HOME}/.tmux.conf \
	${HOME}/.vimrc \
	${HOME}/.asdfrc

${HOME}/.zshrc: ${HOME}/.zshenv ${HOME}/.zshrc.local
	ln -fs $(DOTFILES)/etc/.zshrc ${HOME}/.zshrc

${HOME}/.zshenv:
	ln -fs $(DOTFILES)/etc/.zshenv ${HOME}/.zshenv

${HOME}/.zshrc.local:
	-yes n | cp -i $(DOTFILES)/etc/.zshrc.local ${HOME}/.zshrc.local

${HOME}/.gitconfig: ${HOME}/.gitconfig.ignore ${HOME}/.gitconfig.local
	ln -fs $(DOTFILES)/etc/.gitconfig ${HOME}/.gitconfig

${HOME}/.gitconfig.ignore:
	ln -fs $(DOTFILES)/etc/.gitconfig.ignore ${HOME}/.gitconfig.ignore

${HOME}/.gitconfig.local:
	-yes n | cp -i $(DOTFILES)/etc/.gitconfig.local ${HOME}/.gitconfig.local

${HOME}/.tmux.conf: ${HOME}/.tmux-powerlinerc ${HOME}/.tmux
	ln -fs $(DOTFILES)/etc/.tmux.conf ${HOME}/.tmux.conf

${HOME}/.tmux-powerlinerc:
	ln -fs $(DOTFILES)/etc/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc

${HOME}/.tmux:
	ln -fsn $(DOTFILES)/etc/.tmux ${HOME}/.tmux

${HOME}/.vimrc:
	ln -fs $(DOTFILES)/etc/.vimrc ${HOME}/.vimrc

${HOME}/.asdfrc:
	ln -fs $(DOTFILES)/etc/.asdfrc ${HOME}/.asdfrc

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
tpm: brew
	$(DOTFILES)/etc/tmux/plugins/tpm/bin/install_plugins

.PHONY: tmux
tmux: brew
	brew install tmux

.PHONY: mas
mas: brew
	brew install mas

.PHONY: masapps
masapps: mas
	cat etc/maslist | awk '{print $$1}' | xargs -n1 mas install

etc/maslist:
	mas list | awk '{NF=NF-1}1' | grep -vxFf etc/masignore > $@

.PHONY: cask
cask: brew
	cat etc/casklist | xargs -n1 brew install --cask

etc/casklist:
	brew list --cask | grep -vxFf etc/caskignore > $@
