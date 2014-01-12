# Var
DOTFILES := $(shell pwd)

# Makefile
all: clean neobundle
install: symlink
clean:
	rm -Rf .vim/bundle/neobundle.vim
neobundle:
	git clone https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim
symlink:
	ln -fs $(DOTFILES)/.zshrc ${HOME}/.zshrc
	ln -fs $(DOTFILES)/.zshenv ${HOME}/.zshenv
	ln -fs $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
	ln -fs $(DOTFILES)/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc
	ln -fsn $(DOTFILES)/.vim ${HOME}/.vim
	ln -fs $(DOTFILES)/.vimrc ${HOME}/.vimrc
