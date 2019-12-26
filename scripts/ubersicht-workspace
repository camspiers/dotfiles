#!/bin/bash

check=`ps -ef | grep "yabai" | grep -v "grep" | wc -l | cut -d " " -f8`

if [ $check -ge 1 ]; then
  index=`/usr/local/bin/yabai -m query --spaces --space | grep 'index' | sed 's/[^0-9]*//g'`
  echo -n "$index"
else
  echo -n ""
fi
