#!/bin/sh

# NOTE: This script requires pipewire & wireplumber

# Determine is volume is muted or not
soundmute() {
		if [ "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)" ]; then
			echo true
		else
			echo false
		fi
}

# Just print out the sound volume, that's really all
soundvol() {
		echo "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed -e 's/^.*: //')"
}

# Determine if the microphone is muted
micmute() {
		if [ "$(wpctl get-volume 49 | grep MUTED)" ]; then
			echo true
		else
			echo false
		fi
}

# Print the microphone volume
micvol() {
		echo "$(wpctl get-volume 49 | sed -e 's/^.*: //')"
}

if [[ $1 == "--soundmute" ]]; then
	soundmute
elif [[ $1 == "--soundvol" ]]; then
	soundvol
elif [[ $1 == "--micmute" ]]; then
	micmute
elif [[ $1 == "--micvol" ]]; then
	micvol
fi
