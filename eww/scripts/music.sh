#!/bin/bash
# Written from scratch by likalium :)

playicon_lockfile="$HOME/.cache/eww_play_button.lock"
musicfile="$(MPD_HOST="$HOME/.mpd/socket" mpc -f %file% | head -n 1)"
touch /tmp/art.png

manual_watch() {
	while true; do
		$1 | grep -v "volume"
		sleep 1
	done
}

art() {
	if [ "$(mpc readpicture "$HOME/Music/$musicfile" | head -n 1)" == "No data" ]; then
		cat "$HOME/.mpd/default.png" > /tmp/art.png
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
	command() { mpc -f %artist%:%album%:%title%:%date%:%time% | head -n 1;};manual_watch "command"
	elif [ "$1" == "--title" ]; then
		manual_watch "mpc current"
	elif [ "$1" == "--art" ]; then
		manual_watch "art"
	elif [ "$1" == "--album" ]; then
		command() { mpc status -f "on [[%album%], [%date%]]|[%album%]" | head -n 1 | cut -d "-" -f1;} && manual_watch "command"
		elif [ "$1" == "--play" ]; then
			mpc play
		elif [ "$1" == "--pause" ]; then
			mpc pause
		elif [ "$1" == '--playicon' ]; then
			playerctl -Fp mpd metadata -f "{{lc(status)}}"
		elif [ "$1" == '--shuffle' ]; then
			mpc shuffle
		elif [ "$1" == '--previous' ]; then
			mpc prev
		elif [ "$1" == '--next' ]; then
			mpc next
		elif [ "$1" == '--percenttime' ]; then
			command() { mpc status %percenttime% | sed 's/%//;s/ //g';} && manual_watch "command"
			elif [ "$1" == '--currenttime' ]; then
				manual_watch "mpc status %currenttime%"
			elif [ "$1" == '--length' ]; then
				manual_watch "mpc status %totaltime%"
			elif [ "$1" == '--volume' ]; then
				command() { mpc volume | cut -d ':' -f2 | sed 's/ //g;s/%//';} && manual_watch "command"
				elif [ "$1" == '--repeat' ]; then
					manual_watch "repeat"
fi
