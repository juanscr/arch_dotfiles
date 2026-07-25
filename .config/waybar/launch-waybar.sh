#!/bin/sh

killall waybar;

# Sync waybar style with the user's current theme (light/dark).
current_theme=$(cat ~/.local/share/.user_current_theme 2>/dev/null)
if [ "$current_theme" = "light" ]; then
    cp ~/.config/waybar/style-light.css ~/.config/waybar/style.css
else
    cp ~/.config/waybar/style-dark.css ~/.config/waybar/style.css
fi

number_of_monitors=$(hyprctl monitors active | grep "Monitor" | wc -l);
if [ $number_of_monitors = "2" ]; then
    nohup waybar -c ~/.config/waybar/two-monitor-config.jsonc &>/dev/null &
else
    nohup waybar -c ~/.config/waybar/one-monitor-config.jsonc &>/dev/null &
fi
