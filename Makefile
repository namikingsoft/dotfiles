# Var
DOTFILES := $(shell pwd)

# Makefile
all: submodule
install: symlink neobundle tpm
submodule:
	git submodule init
	git submodule update
	-git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	ln -fsn ${DOTFILES}/vendor/gitmodules/neobundle.vim ${DOTFILES}/etc/vim/bundle/neobundle.vim
	ln -fsn ${DOTFILES}/vendor/gitmodules/vimproc.vim ${DOTFILES}/etc/vim/bundle/vimproc.vim
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
	-yes y | vim +VimProcInstall +qall
	-vim -N -u NONE -i NONE -V1 -e -s --cmd "source ~/.vimrc" --cmd NeoBundleInstall --cmd qall!
	-yes y | vim +NeoBundleClean +qall
tpm:
	~/.tmux/plugins/tpm/bin/install_plugins
lpm:
	wget -O /tmp/lpm http://www.kasahara.ws/lpm/lpm
	chmod +x /tmp/lpm
	/tmp/lpm --local local initlocaldir
