#!/bin/bash
lockfile="$HOME/.cache/power.lock"
if [ ! -f "$lockfile" ]; then
	touch "$lockfile"
	eww update x=true
else
	rm $lockfile
	eww update x=false
fi
echo $x
