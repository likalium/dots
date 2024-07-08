# Written from scratch by likalium :) (but ok it wasn't difficult to write)

sleep 2; if [ -z "`ps -A | grep spotify`" ] && [ -n "`hyprctl workspaces | grep spotify`" ]; then
	`spotify`
fi
