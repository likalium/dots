#!/bin/bash
bat=$(ls /sys/class/power_supply)
bat=$(echo $bat | cut -d " " -f2)
if [ $bat == "AC" ]; then
	echo $bat # Means there is no battery
elif [ "$1" == "--bat" ]; then
	cat /sys/class/power_supply/$bat/capacity
elif [ "$1" == "--status" ]; then
	cat /sys/class/power_supply/$bat/status
else
	echo "--bat	To print the current battery level of charge"
	echo "--status 	To print the current battery state"
fi
