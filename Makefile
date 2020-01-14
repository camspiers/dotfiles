DOTFILES=${HOME}/.dotfiles
TMUX_SHARE=${HOME}/.local/share/tmux
NVIM_SHARE=${HOME}/.local/share/nvim

all: brew neovim tmux skhd fzf-marks

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

brew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"

neovim:
	python3 -m pip install --upgrade pynvim
	curl -fLo ${NVIM_SHARE}/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall

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

.PHONY: all install brew neovim skhd tmux
