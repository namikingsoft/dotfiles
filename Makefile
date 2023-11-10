DOTFILES := $(shell pwd)

.PHONY: all
all: submodule

.PHONY: install
install: symlink asdf brew brewapps mas masapps cask

.PHONY: submodule
submodule:
	git submodule init
	git submodule update

.PHONY: symlink
symlink: \
	${HOME}/.zshrc \
	${HOME}/.gitconfig \
	${HOME}/.tmux.conf \
	${HOME}/.vimrc \
	${HOME}/.asdfrc \
	${HOME}/.zsh-yarn-completions \
	${HOME}/icloud

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

${HOME}/.tmux.conf: ${HOME}/.tmux-powerlinerc ${HOME}/.tmux/plugins/tpm
	ln -fs $(DOTFILES)/etc/.tmux.conf ${HOME}/.tmux.conf

${HOME}/.tmux-powerlinerc:
	ln -fs $(DOTFILES)/etc/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc

${HOME}/.tmux/plugins/tpm:
	mkdir -p ${HOME}/.tmux/plugins
	ln -fsn ${DOTFILES}/vendor/gitmodules/tpm ${HOME}/.tmux/plugins/tpm

${HOME}/.vimrc:
	ln -fs $(DOTFILES)/etc/.vimrc ${HOME}/.vimrc

${HOME}/.asdfrc:
	ln -fs $(DOTFILES)/etc/.asdfrc ${HOME}/.asdfrc

${HOME}/.zsh-yarn-completions:
	ln -fsn ${DOTFILES}/vendor/gitmodules/zsh-yarn-completions ${HOME}/.zsh-yarn-completions

${HOME}/icloud:
	ln -fsn ~/Library/Mobile\ Documents/com~apple~CloudDocs/ ${HOME}/icloud

.PHONY: brew
brew:
	hash brew || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: brewapps
brewapps: brew
	cat etc/brewlist | xargs -L1 brew install

.PHONY: tpm
tpm: brew
	$(DOTFILES)/etc/tmux/plugins/tpm/bin/install_plugins

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

.PHONY: asdf
asdf:
	ln -fsn ${DOTFILES}/vendor/gitmodules/asdf ${HOME}/.asdf
	. ${HOME}/.asdf/asdf.sh
	cat etc/.asdflist | xargs -L1 asdf plugin add || true

etc/.asdflist:
	asdf plugin list --urls > $@
