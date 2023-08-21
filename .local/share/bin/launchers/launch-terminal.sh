#!/usr/bin/env bash

if [ `"$HOME"/.config/qtile/check_number_of_monitors.sh` == 1 ]; then
    alacritty -o=font.size=9 "$@"
else
    alacritty "$@"
fi
