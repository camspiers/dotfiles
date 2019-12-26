### ---------
### Exports
### ---------

function join { local IFS="$1"; shift; echo "$*"; }

PATHS=()

# Brew scripts
PATHS+=("/usr/local/bin:/usr/local/sbin")

# Global npm scripts
PATHS+=("/usr/local/share/npm/bin")

# Global yarn scripts
PATHS+=($(yarn global bin))

# Coreutils
PATHS+=("/usr/local/opt/coreutils/libexec/gnubin")

# Personal scripts
PATHS+=("$HOME/.dotfiles/scripts")

# Global composer scripts
PATHS+=("$HOME/.composer/vendor/bin")

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
PATHS+=("$HOME/.rv")

export PATH="$PATH:$(join ":" "${PATHS[@]}")"

export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Configure fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
