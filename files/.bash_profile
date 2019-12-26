# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Harvest 
source $(ruby -e "print File.dirname(Gem.bin_path('hcl', 'hcl'))")/_hcl_completions

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR='nvim'

# Fast Node Manager
eval "$(fnm env --multi)"

