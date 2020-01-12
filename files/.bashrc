export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
shopt -s expand_aliases

alias c='clear'
alias cat='bat'
alias dco='docker-compose'
alias dk='dockerkill'
alias ld='lazydocker'
alias lg='lazygit'
alias ls='ls -lah --color=auto'
alias ms='tmuxinator-fzf-start.sh'
alias rd='readydocker.sh'
alias v='nvim'

# Enable fzf for bash completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Enable marks plugin
source $HOME/fzf-marks/fzf-marks.plugin.bash

# Configure starship
eval "$(starship init bash)"
