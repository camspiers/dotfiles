#!/usr/bin/env bash

###############################################################
# Tmuxinator FZF Start
###############################################################
#
# Uses fzf to provide a selection list for tmuxinator projects.
#
# Overview:
#
# tmuxinator-fzf-start.sh will open fzf with a multi select
# list of tmuxinator projects.  Upon selecting project/s each
# project will have `tmuxinator start` run, and when complete
# tmux will be attached, or if tmux is already running, a
# session selection interface will be provided.
#
# If an initial query is provided, and only one match results,
# the project will be automatically opened without user input.
#
# Usage:
#
# tmuxinator-fzf-start.sh
# tmuxinator-fzf-start.sh "Query"
#
# Expectations:
#
# - tmuxinator is on $PATH
# - fzf is on $PATH
# - tmux is on $PATH

# Allow the user to select projects via fzf
SELECTED_PROJECTS=$(tmuxinator list -n |
    tail -n +2 |
    fzf --prompt="Project: " -m -1 -q "$1" --reverse --height 50%)

if [ -n "$SELECTED_PROJECTS" ]; then
    # Set the IFS to \n to iterate over \n delimited projects
    IFS=$'\n'

    # Start each project without attaching
    for PROJECT in $SELECTED_PROJECTS; do
        tmuxinator start "$PROJECT" -a false # force disable attaching
    done

    # If inside tmux then select session to switch, otherwise just attach
    if [ -n "$TMUX" ]; then
        SESSION=$(tmux list-sessions -F "#S" | fzf --prompt="Session: " --reverse --height 50%)
        if [ -n "$SESSION" ]; then
            tmux switch-client -t "$SESSION"
        fi
    else
        tmux attach-session
    fi
fi

