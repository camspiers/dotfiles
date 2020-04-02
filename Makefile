DOTFILES=${HOME}/.dotfiles
TMUX_SHARE=${HOME}/.local/share/tmux

all: brew neovim vim tmux skhd fzf-marks bat

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

brew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"
	sudo tlmgr install latexmk

neovim:
	python3 -m pip install --upgrade pynvim
	nvim +PlugInstall +qall

vim:
	ln -s ${DOTFILES}/files/.config/nvim ~/.vim
	ln -s ${DOTFILES}/files/.config/nvim/init.vim ~/.vimrc

tmux:
	if [ ! -d "$(TMUX_SHARE)/plugins/tpm" ]; then git clone https://github.com/tmux-plugins/tpm "$(TMUX_SHARE)/plugins/tpm"; fi
	tmux start-server
	tmux new-session -d
	${TMUX_SHARE}/plugins/tpm/scripts/install_plugins.sh
	tmux kill-server

skhd:
	ln -sfn "$(DOTFILES)/files/.config/skhd/skhdrc" "$(HOME)/.skhdrc"

fzf-marks:
	if [ ! -d ~/fzf-marks ]; then git clone https://github.com/urbainvaes/fzf-marks.git ~/fzf-marks; fi

bat:
	bat cache --build

.PHONY: all install brew neovim vim skhd tmux bat
