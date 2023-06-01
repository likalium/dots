#!/bin/sh
cal() {
	lockfile="$HOME/.cache/eww_cal.lock"
	if [[ ! -f $lockfile ]]; then
		touch "$lockfile"
		eww open calendar && echo "yay"
	else
		eww close calendar
		rm "$lockfile" && echo "no more calendar"
	fi
}
if [ "$1" == cal ]; then
	cal
fi
