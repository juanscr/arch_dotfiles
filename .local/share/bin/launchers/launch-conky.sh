#!/usr/bin/env bash

killall conky
host_computer=$(hostnamectl hostname)
if [ "$host_computer" = "juanscr-acer-laptop" ]; then
    conky_prefix="acer"
else
    conky_prefix="work-laptop"
fi

conky \
    --config="$HOME"/.config/conky/$conky_prefix-conky.conf \
    -a top_right -x 30 -y 70 &
