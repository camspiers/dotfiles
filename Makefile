DOTFILES="${HOME}/.dotfiles"
SCRIPTS="${DOTFILES}/scripts"

all: homebrew neovim

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

homebrew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"
	brew cleanup
	brew doctor
neovim:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ubersicht:
	ln -s "${DOTFILES}/files/.config/ubersicht" "${HOME}/Library/Application Support/Übersicht/widgets/dotfiles"

.PHONY: all install homebrew neovim
