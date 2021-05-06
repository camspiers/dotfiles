DOTFILES=${HOME}/.dotfiles
TMUX_SHARE=${HOME}/.local/share/tmux

all: brew skhd bat

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

brew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"

skhd:
	ln -sfn "$(DOTFILES)/files/.config/skhd/skhdrc" "$(HOME)/.skhdrc"

bat:
	bat cache --build

.PHONY: all install brew skhd tmux
