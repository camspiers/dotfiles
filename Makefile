DOTFILES=${HOME}/.dotfiles

all: homebrew neovim tmux skhd

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

homebrew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"

neovim:
	python3 -m pip install --upgrade pynvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/tmux-plugins/tpm

skhd:
	ln -s "$DOTFILES/files/.config/skhd/skhdrc" "$HOME/.skhdrc"

.PHONY: all install homebrew neovim skhd tmux
