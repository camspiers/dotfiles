#!/usr/bin/env bash

exists () {
  type "$1" &> /dev/null ;
}

if exists /usr/local/bin/ifstat ; then
  down=`/usr/local/bin/ifstat -n -z -S 1 1 | awk 'FNR == 3 {print $2}'`
  up=`/usr/local/bin/ifstat -n -z -S 1 1 | awk 'FNR == 3 {print $3}'`
  echo "↓ ${down} ↑ ${up}"
else
  echo "↓ $(networksetup -getairportnetwork en0 | cut -c 24-)"
fi
