#!/bin/bash

## Script for what is shown on the center of the bar ##

title() {
	hyprctl activewindow | grep "title:" | sed 's/^.\{8\}//'
}

music() {
	echo "music"
}

if [[ $1 == "--title" ]]; then
	title
elif [[ $1 == "--music" ]]; then
	music
else
	echo "--title 		for printing title of the current window"
	echo "--music 		for printing the current playing music"
fi
