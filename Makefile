DOTFILES=${HOME}/.dotfiles
TMUX_SHARE=${HOME}/.local/share/tmux

all: brew neovim vim tmux skhd fzf-marks bat

install:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" files

brew:
	brew bundle --file="$(DOTFILES)/extra/homebrew/Brewfile"

neovim:
	python3 -m pip install --upgrade pynvim
	curl -fLo ${DOTFILES}/files/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall
	nvim +CocInstall coc-phpls +qall
	nvim +CocInstall coc-vimlsp +qall
	nvim +CocInstall coc-stylelint +qall
	nvim +CocInstall coc-yaml +qall
	nvim +CocInstall coc-sh +qall

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
