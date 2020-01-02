export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

alias lg='lazygit'
alias ld='lazydocker'
alias ms='tmuxinator-fzf-start.sh'

# Enable fzf for bash completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Configure starship
eval "$(starship init bash)"
