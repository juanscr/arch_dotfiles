#!/usr/bin/env bash

if [[ `echo "$XDG_SESSION_TYPE"` == "x11" ]]; then
    if [ `"$HOME"/.config/qtile/monitor_scripts/x11.sh` == 1 ]; then
        alacritty -o=font.size=9 "$@"
    else
        alacritty "$@"
    fi
    exit 0;
fi

alacritty -o=font.size=16 "$@"
