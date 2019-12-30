DOTFILES=${HOME}/.dotfiles

all: homebrew neovim ubersicht activespace

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

homebrew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"
	brew cleanup
	brew doctor
neovim:
	python3 -m pip install --upgrade pynvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ubersicht:
	[[ -e "$(HOME)/Library/Application Support/Übersicht/widgets/dotfiles" ]] || ln -s "$(DOTFILES)/files/.config/ubersicht" "$(HOME)/Library/Application Support/Übersicht/widgets/dotfiles"
	cd "$(DOTFILES)/files/.config/ubersicht" && yarn install

activespace:
	swiftc "$(DOTFILES)/files/.config/ubersicht/activespace.swift" -import-objc-header "$(DOTFILES)/files/.config/ubersicht/activespace.h" -O -o "$(DOTFILES)/scripts/activespace"

.PHONY: all install homebrew neovim ubersicht activespace
