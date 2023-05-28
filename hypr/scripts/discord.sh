# Written from scratch by likalium :) (but ok it wasn't difficult to write)

sleep 2; if [ -z "`ps -A | grep -i discord`" ] && [ -n "`hyprctl workspaces | grep discord`" ]; then
	`discord-canary`
fi
