DOTFILES="${HOME}/.dotfiles"
SCRIPTS="${DOTFILES}/scripts"

all: homebrew neovim

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

homebrew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"
	brew cleanup
	brew doctor

.PHONY: all install homebrew neovim
