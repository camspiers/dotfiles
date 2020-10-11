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
  "/usr/local/opt/ruby/bin" # Ruby
  "/usr/local/sbin" # Brew scripts
  "/usr/local/bin" # Brew scripts
  "/Users/cam/.cargo/bin"
)

# User paths
USER_PATHS=(
  "/opt/metasploit-framework/bin" # Metasploit
  "/usr/local/opt/fzf/bin" # Fzf
  "$HOME/.dotfiles/scripts" # Personal scripts
  "$HOME/.composer/vendor/bin" # Global composer scripts
  "$(/usr/local/opt/ruby/bin/ruby -r rubygems -e 'puts Gem.user_dir')/bin" # Ruby
  "$HOME/Library/Python/3.7/bin" # Python
  "$HOME/.dotnet/tools"
)

# Set PATH with ordering: SYS:PATH:USER
export PATH=$(dedup "$(join SYS_PATHS[@]):$PATH:$(join USER_PATHS[@])")

################################################################################
# Aliases ######################################################################
################################################################################

alias c='clear'
alias cat='bat'
alias dco='docker-compose'
alias dk='dockerkill'
alias dka='dockerkillall'
alias f='fg'
alias ld='lazydocker'
alias lg='lazygit'
alias ls='ls -lah --color=auto'
alias ms='tmuxinator-fzf-start.sh'
alias rd='readydocker.sh'
alias sf='rg --files --hidden --no-ignore | fzf -m'
alias ssh='TERM=xterm-256color ssh'
alias t='tmux'
alias v='nvim'
alias vs='nvim -S Session.vim'

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
eval "$(starship init bash)"
