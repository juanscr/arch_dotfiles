#!/usr/bin/env bash

killall conky
conky \
    --config="$HOME"/.config/conky/conky.conf \
    -a top_right -x 30 -y 70 &
