#!/usr/bin/env bash

usage() { echo "Usage: $0 " 1>&2; exit 1; }

X=''
Y=''
DELTA=false
PERCENT=false
ABSOLUTE=false

while getopts 'dpax:y:' flag; do
  case "${flag}" in
    x) X=${OPTARG} ;;
    y) Y=${OPTARG} ;;
    d) DELTA=true ;;
    p) PERCENT=true ;;
    a) ABSOLUTE=true ;;
    *) usage ;;
  esac
done

TMUX_PANE_INITIAL_HEIGHT=$(tmux display -p -t $TMUX_PANE '#{pane_height}')
TMUX_WINDOW_HEIGHT=$(tmux display -p '#{window_height}')

TMUX_PANE_INITIAL_WIDTH=$(tmux display -p -t $TMUX_PANE '#{pane_width}')
TMUX_WINDOW_WIDTH=$(tmux display -p '#{window_width}')

HEIGHT_DELTA=0
WIDTH_DELTA=0

if $DELTA ; then
  if [ -n "$Y" ]; then
    HEIGHT_DELTA=$Y
  fi
  if [ -n "$X" ]; then
    WIDTH_DELTA=$X
  fi
fi

if $PERCENT ; then
  if [ -n "$Y" ]; then
    HEIGHT_ABSOLUTE_FLOAT=$(echo "scale=2; $Y * $TMUX_WINDOW_HEIGHT" | bc)
    HEIGHT_ABSOLUTE=${HEIGHT_ABSOLUTE_FLOAT%.*}
    HEIGHT_DELTA=$((HEIGHT_ABSOLUTE - TMUX_PANE_INITIAL_HEIGHT))
  fi
  if [ -n "$X" ]; then
    WIDTH_ABSOLUTE_FLOAT=$(echo "scale=2; $X * $TMUX_WINDOW_WIDTH" | bc)
    WIDTH_ABSOLUTE=${WIDTH_ABSOLUTE_FLOAT%.*}
    WIDTH_DELTA=$((WIDTH_ABSOLUTE - TMUX_PANE_INITIAL_WIDTH))
  fi
fi

if $ABSOLUTE ; then
  if [ -n "$Y" ]; then
    HEIGHT_DELTA=$((Y - TMUX_PANE_INITIAL_HEIGHT))
  fi
  if [ -n "$X" ]; then
    WIDTH_DELTA=$((X - TMUX_PANE_INITIAL_WIDTH))
  fi
fi

DURATION=300
START_TIME=$(date +%s%3N)
END_TIME=$((START_TIME + DURATION))

while [ $(date +%s%3N) -lt $END_TIME ]; do
  sleep 0.016
  ELAPSED=$(($(date +%s%3N) - START_TIME))
  HEIGHT_FLOAT=$(echo "scale=2; $HEIGHT_DELTA * ($ELAPSED / $DURATION) + $TMUX_PANE_INITIAL_HEIGHT" | bc)
  HEIGHT=${HEIGHT_FLOAT%.*}
  WIDTH_FLOAT=$(echo "scale=2; $WIDTH_DELTA * ($ELAPSED / $DURATION) + $TMUX_PANE_INITIAL_WIDTH" | bc)
  WIDTH=${WIDTH_FLOAT%.*}
  tmux resize-pane -y $HEIGHT -x $WIDTH
done
