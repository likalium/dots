## Put you key here
key=
## Put your latitude here
lat=
## Put your longitude here
lon=
## For fetching weather datas
weather=$(curl -s "https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${key}&units=metric")

today=$(date +%F)
hour=$( echo $weather | jq ".list[0].dt_txt" | cut -d " " -f2 | cut -d ":" -f1)

## About this script: In the response of the OpenWeatherMap API, the element 0 of the "list" table is relative to the current time (i'm too lzay for explaining this, analyze the responses by yourself). Knowing that, the addition we must do to retrieve the datas for the next day at 00:00 changes. $y is the value by which to add to retrieve theses datas.
y=$(( 8 - $hour/3 ))
#for i in {0..5}; do
#	for j in {0..7}; do
#		x=$j
#		echo $x
#	done
#done
tomorrow=$(echo $weather | jq ".list[$y].weather[0].id")
icon() {
	if [[ $1 -ge 200 ]] && [[ $1 -le 202 ]]; then
		icon_day=""
		icon_night=""
		text="Thunderstorm with rain"
	elif [[ $1 -ge 210 ]] && [[ $1 -le 221 ]]; then
		icon_day=""
		icon_night=""
		text="Thunderstorm"
	elif [[ $1 -ge 230 ]] && [[ $1 -le 232 ]]; then
		icon_day=""
		icon_night=""
		text="Thunderstorm with drizzle"
	elif [[ $1 -ge 300 ]] && [[ $1 -le 302 ]]; then
		icon_day=""
		icon_night=""
		text="Drizzle"
	elif [[ $1 -ge 310 ]] && [[ $1 -le 312 ]]; then
		icon_day=""
		icon_night=""
		text="Drizzle rain"
	elif [[ $1 -ge 313 ]] && [[ $1 -le 321 ]]; then
		icon_day=""
		icon_night=""
		text="Shower drizzle"
	elif [[ $1 -ge 500 ]] && [[ $1 -le 504 ]]; then
		icon_day=""
		icon_night=""
		text="Rain"
	elif [[ $1 == 511 ]]; then
		icon_day=""
		icon_night=$icon_day
		text="Freezing rain"
	elif [[ $1 -ge 520 ]] && [[ $1 -le 531 ]]; then
		icon_day=""
		icon_night=$icon_day
		text="Shower Rain"
	elif [[ $1 -ge 600 ]] && [[ $1 -le 622 ]]; then
		icon_day=""
		icon_night=""
		text="Snow"
	elif [[ $1 == 701 ]]; then
		icon_day=""
		icon_night=""
		text="Mist"
	elif [[ $1 == 741 ]]; then
		icon_day=""
		icon_night=""
		text="Fog"
	elif [[ $1 == 762 ]]; then
		icon_day=""
		icon_night=$icon_day
		text="Ash"
	elif [[ $1 == 781 ]]; then
		icon_day=""
		icon_night=$icon_day
		text="Tornado"
	elif [[ $1 -ge 711 ]] && [[ $1 -le 781 ]]; then
		icon_day=""
		icon_night=""
		if [[ $1 == 711 ]]; then
			text="Smoke"
		elif [[$1 == 721 ]]; then
			text="Haze"
		elif [[ $1 == 731 ]] || [[ $1 == 761 ]]; then
			text="Dust"
		elif [[ $1 == 771 ]]; then
			text="Squalls"
		fi
	elif [[ $1 == 800 ]]; then
		icon_day=""
		icon_night=""
		text="Clear"
	else
		icon_day=""
		icon_night=$icon_day
		text="Clouds"
	fi
}

if [[ $hour -ge 7 ]] && [[ $hour -le 21 ]]; then
	icon=$icon_day
else
	icon=$icon_night
fi

current_temp=$(echo $weather | jq ".list[0].main.temp")

if [[ "$1" == '--temp' ]]; then
	echo $current_temp
elif [[ "$1" == '--icon' ]]; then
	icon
elif [[ "$1" == '--weather' ]]; then
	echo $weather
elif [[ $1 == "--text" ]]; then
	echo $text
else
	echo "--weather 	for printing the current weather datas (not used in eww, it's for debug)"
	echo "--temp 		for printing current weather temp"
	echo "--icon 		for printing weather icon code. It requires you to enter the corresponding weather code in argument."
	echo "--text 		for a litteral description of the weather"
fi
