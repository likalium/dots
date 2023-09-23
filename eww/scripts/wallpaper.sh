#/bin/sh

# Change wallpaper with a nice animation :)
function img() {
	img=$(find $1 -type f | shuf -n 1)
	swww img "$img" -t grow --transition-pos 1218,747
	
}


# Retrieve dominant color of current wallpaper
# NOTE: I chose to don't use that bc it ruins the harmony between colors. You can still use it, if you want.
# function color() {
# 	color="$(convert $img -scale 50x50! +dither -format %c -depth 8  histogram:info: \
# 		| sort -n | tail -1 | sed 's/^ *//;s/ /@/g' | cut -d@ -f3)"
# 	echo "$color"
# }

# Choose a random colors, from a file which contains all colors. It cant echo the same colors 2 times in a row
# NOTE: I chose this version bc like this, you keep an harmony between colors. It would be better to have a script which analyzes colors code and return a wanted color depending on the colors (eg, if the color is blue, then return MY blue), i'll see if i can do that but i'm not confident about it.
function color() {
	color="$(cat "$HOME/.config/eww/tokyonight_colors" | shuf -n 1)"
	if [[ "$color" == "$(cat /tmp/eww_color)" ]]; then
		color
	fi
	echo $color > /tmp/eww_color
	echo $color
	
}
if [[ $1 == "--img" ]]; then
	img $2
elif [[ "$1" == "--color" ]]; then
	color
else
	echo "--img 	Select a random image from a given directory. Usage: --img <directory_wuth_images>"
	echo "--color	Print the hex code of the dominant color of the current image"
fi
