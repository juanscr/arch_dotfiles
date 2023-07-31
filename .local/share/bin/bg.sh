#!/bin/bash

if [ "$#" -lt 1 ]; then
    photo=$(find "$HOME"/.local/share/assets/wallpapers/ -name '*.jpg' | shuf -n 1)
else
    photo=$1
fi

feh --no-fehbg --bg-scale "$photo"
betterlockscreen -u "$photo"
