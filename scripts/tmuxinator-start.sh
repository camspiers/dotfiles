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
#

tmuxinator list -n |
    tail -n +2 |
    fzf -m -1 -q "$1" --reverse --height 50% |
    while read project; do
        tmuxinator start "$project"
    done
