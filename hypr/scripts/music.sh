#!/bin/sh

# Content of our notification
title=""
content=""

# Toggles random mode
function random() {
	mpc random
	title = "Random"
	content = "Random $(mpc status %random%)"
}

# Increase or decrease volume
function changeVol() {
	title="Volume"
	if [[ $1 == "left" ]]; then
		mpc volume -2
		content="Volume -2%"
	else
		mpc volume +2
		content="Volume +2%"
	fi
	content+=" - Now $(mpc status %volume% | sed -e 's/^ //g')"
}

# Toggles repeat mode
function repeating() {
		title="Repeat"
		mpc repeat
		content="Repeat $(mpc status %repeat%)"
}

# Switchs to previous or next song
function changeSong() {
	if [[ $1 == "prev" ]]; then
		title="Previous song"
		mpc prev
	else
		title="Next song"
		mpc next
	fi
	content="$(mpc current)"
}

# Toggle single mode
function single() {
	mpc single
	title="Single"
	content="Single: $(mpc status %single%)"
}

# Prints a bunch of datas
function status() {
	artist="$(mpc status -f %artist% | head -1)"
	song="$(mpc status -f %title% | head -1)"
	currenttime="$(mpc status %currenttime%)"
	totaltime="$(mpc status %totaltime%)"
	percenttime="$(mpc status %percenttime% | sed -e 's/ //g')"
	volume="$(mpc status %volume%)"
	state="$(mpc status %state%)"
	random="$(mpc status %random%)"
	single="$(mpc status %single%)"
	title="Status"
	content="${artist} - ${song}\n${currenttime}/${totaltime} (${percenttime}) \nState: ${state}\nVolume: ${volume}\nRandom: ${random}\nSingle: ${single}"
}
case $1 in
	"--random")
		shuffle
		;;
	"--vol")
		changeVol $2
		;;
	"--repeat")
		repeating
		;;
	"--change")
		changeSong $2
		;;                                 
	"--single")
		single
		;;
	"--status")
		status
		;;
esac
notify-send -a "MPD" "$title" "$content"
