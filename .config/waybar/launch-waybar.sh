#!/bin/sh

killall waybar;
number_of_monitors=$(hyprctl monitors active | grep "Monitor" | wc -l);
if [ $number_of_monitors = "2" ]; then
    nohup waybar -c ~/.config/waybar/two-monitor-config.jsonc &>/dev/null &
else
    nohup waybar -c ~/.config/waybar/one-monitor-config.jsonc &>/dev/null &
fi
