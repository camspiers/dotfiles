#!/usr/bin/env bash

###############################################################
# Tmuxinator Start
###############################################################
#
# Uses fzf to provide a quick filtering and selection list 
# (including multi select) for tmuxinator projects
#
# Usage:
#
# tmuxinator-start.sh
# tmuxinator-start.sh "Initial Query"

projects=$(
    tmuxinator list -n |
        tail -n +2 |
        fzf --prompt="Project: " -m -1 -q "$1" --reverse --height 50%
)

IFS=$'\n'

for project in $projects; do
    tmuxinator start "$project" -a false # disable attaching
done

if [ -n "$TMUX" ]; then
    session=$(tmux list-sessions -F "#S" | fzf --prompt="Session: " --reverse --height 50%)
    tmux switch-client -t "$session"
else
    tmux a
fi

