#!/bin/bash

playicon_lockfile="$HOME/.cache/eww_play_button.lock"
musicfile="$(mpc -f %file% | head -1)"
tocheck="$(mpc readpicture "$musicfile" | head -1 | cut -c1-7 1>/dev/null)"

art() {
	if [[ "$tocheck" == "No data" ]]; then
		cat "/home/likalium/.mpd/nocover.png" > /tmp/art.png
	else
		mpc readpicture "$musicfile" > /tmp/art.png
	fi
}

repeat() {
	if [ "$(mpc status %repeat%)" == "off" ]; then
		echo "repeat-off-single-off"
	elif [ "$(mpc status %repeat%)" == "on" ] && [ "$(mpc status %single%)" == "off" ]; then
		echo "repeat-on-single-off"
	else
		echo "repeat-on-single-on"
	fi
}

if [ "$1" == "--infos" ]; then
	mpc -f %artist%:%album%:%title%:%date%:%time% | head -n 1
elif [ "$1" == "--title" ]; then
	mpc current
elif [ "$1" == "--art" ]; then
	art
elif [ "$1" == "--album" ]; then
	mpc status -f "on [[%album%], [%date%]]|[%album%]" | head -n 1 | cut -d "-" -f1
elif [ "$1" == '--percenttime' ]; then
	mpc status %percenttime% | sed 's/%//;s/ //g'
elif [ "$1" == '--currenttime' ]; then
	mpc status %currenttime%
elif [ "$1" == '--length' ]; then
	mpc status %totaltime%
elif [ "$1" == '--volume' ]; then
	mpc volume | cut -d ':' -f2 | sed 's/ //g;s/%//'
elif [ "$1" == "--repeat" ]; then
	repeat
fi
