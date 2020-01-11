DOTFILES=${HOME}/.dotfiles

all: brew neovim tmux skhd

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

brew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"

neovim:
	python3 -m pip install --upgrade pynvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/tmux-plugins/tpm
	tmux start-server
	tmux new-session -d
	~/tmux-plugins/tpm/scripts/install_plugins.sh
	tmux kill-server

skhd:
	ln -s "$DOTFILES/files/.config/skhd/skhdrc" "$HOME/.skhdrc"

.PHONY: all install brew neovim skhd tmux
