#!/bin/bash

function setBg() {
    if [[ `echo "$XDG_SESSION_TYPE"` == "x11" ]]; then
        feh --no-fehbg --bg-scale $1
        betterlockscreen -u $1
        return;
    fi
    swaybg -i $1 &
    mkdir -p ~/.local/share/hyprlock/ && ln -sf $1 ~/.local/share/hyprlock/bg.jpg
}

if [ "$#" -lt 1 ]; then
    photo=$(find "$HOME"/.local/share/assets/wallpapers/ -name '*.jpg' | shuf -n 1)
else
    photo=$1
fi

setBg $photo
