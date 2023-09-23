#!/bin/sh

# Determine how many days in month
function month_days() {
	year=$(date +%Y)
	month=$(date +%m | sed 's/^0//')
	# For february. Take in account leap years
	if [[ $month == 2 ]]; then
		if [[ $(( $year % 400 )) -eq 0 ]] || [[ $(( $year % 4 )) -eq 0 && $(( $year % 100 )) -gt 0 ]]; then
			echo 29
		else
			echo 28
		fi
	# For other months
	elif [[ ( $month -le 7 && $(( $month % 2 )) -eq 1 ) || $(( $month % 2 )) -eq 0 ]]; then
		echo 31
	else
		echo 30
	fi
}

# Echo all days in month in a JSON array style
function month() {
	days=$(month_days)
	echo -n '['
	for ((i = 1; i <= $days ; i++)); do
		echo -n "$i,"
		# if [[ $(( $i % 7 )) == 0 ]]; then
		# 	echo ""
		# fi
	done | sed 's/,$//'
	echo ']'
}

case $1 in
	"--days")
		month_days
		;;
	"--month")
		month
		;;
	*)
		echo "--days 	to know how many days the current month has (requires date)"
		;;
esac
