#!/bin/bash

if xrandr --listactivemonitors | grep "HDMI"; then
    flameshot screen -r -c -p "$HOME"/pictures/screenshots
else
    flameshot full -c -p "$HOME"/pictures/screenshots
fi
