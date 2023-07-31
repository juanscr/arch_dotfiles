#!/usr/bin/env bash

killall conky
num_monitors=$("$HOME"/.config/qtile/check_number_of_monitors.sh)
coordinate=$(xrandr --query |
             grep primary |
             grep -o [[:digit:]]\\++[[:digit:]]\\+\\s |
             awk -F+ '{ print $1 }')

# Spawn conky according to layout
if [ "$num_monitors" == 2 ] && [ "$coordinate" == 0 ]; then
    conky &
elif [ "$num_monitors" == 2 ]; then
    conky --config="$HOME"/.config/conky/conky-left.conf
elif xrandr --listactivemonitors | grep "HDMI" ; then
    conky --config="$HOME"/.config/conky/conky-one-hdmi.conf
else
    conky --config="$HOME"/.config/conky/conky-one.conf
fi
