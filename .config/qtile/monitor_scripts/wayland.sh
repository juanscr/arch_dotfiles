#!/usr/bin/sh

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
num_monitors=$((`wlr-randr | awk -vn=5 '/Enabled: yes/{print l[NR%5]};(NR in p);{l[NR%5]=$0}' | wc -l`))
echo $num_monitors
