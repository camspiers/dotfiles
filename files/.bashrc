################################################################################
# Bash Runcom Configuration (Cam Spiers) #######################################
################################################################################

################################################################################
# General Config ###############################################################
################################################################################

export HISTSIZE=100000        # big big history
export HISTFILESIZE=100000    # big big history
shopt -s histappend           # append to history, don't overwrite it
shopt -s expand_aliases

################################################################################
# Path Management ##############################################################
################################################################################

################################################################################
# Joins paths together by ":"
# Arguments:
#     $1: Array of paths, e.g. join ARR[@]
# Returns:
#     string
################################################################################
join() { a=("${!1}"); local IFS=":"; echo "${a[*]}"; }

################################################################################
# Deduplicates paths separated by ":"
# Arguments:
#     $1: string of paths separated by ":"
# Returns:
#     string
################################################################################
dedup() { echo -n $1 | awk -v RS=: -v ORS=: '!arr[$0]++'; }

# System paths
SYS_PATHS=(
  "/usr/local/opt/coreutils/libexec/gnubin" # Prefer coreutils
  "/usr/local/opt/gnu-sed/libexec/gnubin" # Custom sed
  "/usr/local/opt/python/libexec/bin" # Python
  "/usr/local/sbin" # Brew scripts
  "/usr/local/bin" # Brew scripts
)

# User paths
USER_PATHS=(
  "$HOME/.dotfiles/scripts" # Personal scripts
  "$HOME/bin"
  "$HOME/.luarocks/bin"
  "$HOME/.emacs.d/bin"
)

# Set PATH with ordering: SYS:PATH:USER
export PATH=$(dedup "$(join SYS_PATHS[@]):$PATH:$(join USER_PATHS[@])")

################################################################################
# Aliases ######################################################################
################################################################################

alias c='clear'
alias cat='bat'
alias f='fg'
alias lg='lazygit'
alias ls='ls -lahG'
alias ms='tmuxinator-fzf-start.sh'
alias ssh='TERM=xterm-256color ssh'
alias t='tmux'
alias v='nvim'

################################################################################
# Bindings #####################################################################
################################################################################

# Provide a shortcut for foregrounding the last job
bind -x '"\C-f":"fg"'

################################################################################
# Plugins ######################################################################
################################################################################

# Enable fzf for bash completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Enable marks plugin
source $HOME/fzf-marks/fzf-marks.plugin.bash

# Configure starship
# eval "$(starship init bash)"

alias luamake=/Users/camspiers/dev/lua-language-server/3rd/luamake/luamake

eval "$(rbenv init - bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
