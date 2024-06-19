#!/usr/bin/env bash

# Function for checking mirror displays
mirrored="same"
nmirrored="diff"
checkMirrorDisplays () {
    awkInput="(NR > 1) { split(\$3, a, \"+\"); print a[2] \"+\" a[3] }"
    coords=$(xrandr --listactivemonitors | awk "$awkInput")

    # Check if all coordinates are the same
    outputAwk="{ print count == 1 ? \"$mirrored\" : \"$nmirrored\" }"
    echo "$coords" | awk "!unique[\$0]++ { count++ } END $outputAwk"
}

# Output the number of monitors
num_monitors=$((`xrandr --listactivemonitors | wc -l` - 1))
mirror=$(checkMirrorDisplays)
if [ "$num_monitors" != 1 -a "$mirror" == "$mirrored" ]; then
    num_monitors=1
fi
echo $num_monitors
