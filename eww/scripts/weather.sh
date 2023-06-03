#!/bin/bash
## Put your API key here
key=
## Put your latitude here
lat=
## Put your longitude here
lon=

weather=$(curl -s 'https://api.openweathermap.org/data/2.5/forecast?lat='${lat}'&lon='${lon}'&appid='${key}'&units=metric' | awk -F'\\}' '{print $1,$2}')
temp=$(echo $weather | awk -F'\"' '{print $17}' | sed 's/^.//;s/.$//' | xargs printf "%.0f\n")
icon=$(echo $weather | awk -F'\"' '{print $48}')

if [ "$1" == '--temp' ]; then
	echo $temp
elif [ "$1" == '--icon' ]; then
	echo $icon
elif [ "$1" == '--weather' ]; then
	echo $weather
else
	echo "--weather 	for printing the current weather datas (not used in eww, it's for debug)"
	echo "--temp 		for printing current temp"
	echo "--icon 		for printing weather icon code"
fi
