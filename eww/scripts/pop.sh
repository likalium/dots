#!/bin/sh
cal_lockfile="$HOME/.cache/eww_cal.lock"
play_lockfile="$HOME/.cache/eww_play.lock"
power_lockfile="$HOME/.cache/eww_power_ext.lock"
cal() {
	if [[ ! -f $cal_lockfile ]]; then
		rm $HOME/.cache/eww*.lock
		touch "$cal_lockfile"
		eww close player power_ext
		eww open calendar && echo "yay"
	else
		eww close calendar
		rm "$cal_lockfile" && echo "no more date"
	fi
}
player() {
	if [[ ! -f $play_lockfile ]]; then
		rm $HOME/.cache/eww*.lock
		touch "$play_lockfile"
		eww close calendar power_ext
		eww open player && echo "MUSIC HELL YEAHH"
	else
		eww close player
		rm "$play_lockfile" && echo "huh bye ig"
	fi
}
power() {
	if [[ ! -f $power_lockfile ]]; then
		rm $HOME/.cache/eww*.lock
		touch "$power_lockfile"
		eww close calendar player
		eww open power_ext && echo "the power is in your hands bro"
	else
		eww close power_ext
		rm "$power_lockfile" && echo "hmmmmmmmmm"
	fi
}

if [ "$1" == "--cal" ]; then
	cal
elif [ "$1" == "--play" ]; then
	player
elif [ "$1" == "--power" ]; then
	power
else
	echo "--cal 		to open calendar window and close all other windows"
	echo "--play 		to open the player window and close all other windows"
	echo "--player	to open the power window and close all other windows"
fi
