#!/bin/bash

# Default function for killing script
die() {
    printf '%s\n' "$1" >&2
    exit 1
}

# Default query for monitor information and devices
queryx='xrandr --listactivemonitors'
queryp='pactl list sources short'

# Default values for variables
monitorRecord=$($queryx | awk '/\+\*/ { print $4 }')
outputVideo='output.mp4'
microphone=$($queryp | awk '/input/ { print $2 }' | head -1)
computer=$($queryp | awk '/output/ { print $2 }' | head -1)
nmic=0
ncomp=0
fps=30

# Global variables to identify events
NOAUDIO=1
USEAUDIO=2

# Help function
help() {
    echo "Record your screen using only ffmpeg. Works for x11 and pulseaudio."
    echo
    echo "The default devices used for the recording will be:"
    echo "  1. Monitor:        $monitorRecord"
    echo "  2. Microphone:     $microphone"
    echo "  3. Computer sound: $computer"
    echo
    echo "For a list of available devices do:"
    echo "  1. Screens:       '$queryx'"
    echo "  2. Audio sources: '$queryp'"
    echo
    echo "Options for script:"
    echo
    echo "-f, --fps FPS            It selects the rate of the recording."
    echo
    echo "-d, --display DEVICE     It allows to select the monitor for which"
    echo "                         the screen will be recorded. For a list of"
    echo "                         available devices do 'xrandr --listmonitors'"
    echo
    echo "-o, --output FILENAME    It changes the name of the output file. It"
    echo "                         has a default value of output.mp4."
    echo
    echo "-m, --mic <DEVICE>       It selects the source for which the"
    echo "                         microphone will be recorded. If the DEVICE"
    echo "                         is not given, it will use the default one."
    echo
    echo "-c, --comp <DEVICE>      It selects the source for which the computer"
    echo "                         sound will be recorded. If the DEVICE"
    echo "                         is not given, it will use the default one."
    echo
    echo "-nm, --nomic             It does not record the microphone sound."
    echo
    echo "-nc, --nocomp            It does not record the computer sound."
    echo
    echo "-h, --help               It prints this menu."
}


# Parse display options
while :; do
    case $1 in
        -d|--display)
            if [ "$2" ]; then
                monitorRecord="$2"

                # Check if monitor exists
                isMonitor=$($queryx | awk "/$monitorRecord/")
                if [ "$isMonitor" = "" ]; then
                    die 'ERROR: The display given does not exist.'
                fi
            else
                die 'ERROR: No display specified.'
            fi
            ;;
        -o|--output)
            if [ "$2" ]; then
                outputVideo="$2"
            else
                die 'ERROR: No name was given to the output option.'
            fi
            ;;
        -m|--mic)
            if [[ "$nmic" == "$NOAUDIO" ]]; then
                die 'ERROR: No mic and mic option selected at the same time.'
            fi

            nmic=$USEAUDIO
            # Add microphone
            if [ "$2" ]; then
                microphone="$2"
            fi
            ;;
        -nm|--nomic)
            if [[ "$nmic" == "$USEAUDIO" ]]; then
                die 'ERROR: No mic and mic option selected at the same time.'
            fi
            nmic=$NOAUDIO
            ;;
        -c|--comp)
            if [[ "$ncomp" == "$NOAUDIO" ]]; then
                die 'ERROR: No mic and mic option selected at the same time.'
            fi

            ncomp=$USEAUDIO
            # Add microphone
            if [ "$2" ]; then
                microphone="$2"
            fi
            ;;
        -nc|--nocomp)
            if [[ "$ncomp" == "$USEAUDIO" ]]; then
                die 'ERROR: No mic and mic option selected at the same time.'
            fi
            ncomp=$NOAUDIO
            ;;
        -f|--fps)
            if [ "$2" ]; then
                fps="$2"
            else
                die 'ERROR: No value for the FPS was passed.'
            fi
            ;;
        -h|--help)
            help
            exit 0
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)
            break
    esac
    shift
done

if [ "$monitorRecord" = "" ]; then
    die 'ERROR: No primary display found or specified.'
fi

if [[ "$nmic" == 0 ]]; then
    nmic=$USEAUDIO
fi
if [[ "$ncomp" == 0 ]]; then
    ncomp=$USEAUDIO
fi

# ===== Information about monitor ===== #
# Obtain coordinate for display
getCoordDisplay() {
    regexMatch="match(\$0, /[0-9]+\+[0-9]+\s/, a)"
    awkInput="/$monitorRecord/ { $regexMatch; print a[0] }"
    coord=$($queryx | awk "$awkInput")
    echo "$coord" | awk '{ gsub("+", ",") } 1'
}

# Obtain resolution for display
getResDisplay() {
    regexMatch="match(\$0, /[0-9]+\/+[0-9]+x[0-9]+/, a)"
    awkInput="/$monitorRecord/ { $regexMatch; print a[0] }"
    display=$($queryx | awk "$awkInput")

    # Depure it
    regexMatch="match(\$0, /\/[0-9]+x/, a)"
    extraStuff=$(echo "$display" | awk "{ $regexMatch; print a[0] }")

    echo "$display" | awk "{ gsub (\"$extraStuff\", \"x\")} 1"
}

coord=$(getCoordDisplay "$monitorRecord")
res=$(getResDisplay "$monitorRecord")

# ===== Information about audio stuff ===== #
# Get channel for a given audio device
getAC() {
    matchChannel="match(\$0, \"[0-9]+ch\", a)"
    channel=$($queryp | awk "/$1/ { $matchChannel; print a[0] }")

    # Get channel
    echo "$channel" | awk '{ gsub("ch", "") } 1'
}

# Get rate for a given audio device
getAR() {
    matchRate="match(\$0, \"[0-9]+Hz\", a)"
    rate=$($queryp | awk "/$1/ { $matchRate; print a[0] }")

    # Get channel
    echo "$rate" | awk '{ gsub("Hz", "") } 1'
}

audioArgs=()
devices=0
audioRate=

# Microphone addition
if [[ "$nmic" == "$USEAUDIO" ]]; then
    # Get info microphone
    channelInput=$(getAC "$microphone")
    rateInput=$(getAR "$microphone")

    # Add arguments
    audioArgs+=(
        -f pulse
        -ac "$channelInput"
        -ar "$rateInput"
        -i "$microphone"
    )

    # Add to device usage
    devices=$((devices + 1))
    audioRate=$rateInput

fi

# Computer addition
if [[ "$ncomp" == "$USEAUDIO" ]]; then
    # Get info computer
    channelOut=$(getAC "$computer")
    rateOut=$(getAR "$computer")

    # Add arguments
    audioArgs+=(
        -f pulse
        -ac "$channelOut"
        -ar "$rateOut"
        -i "$computer"
    )

    # Add to device usage
    devices=$((devices + 1))
    audioRate=$rateOut
fi

# Take into account settings for two audio inputs
if [[ "$devices" == 2 ]]; then
    # Audio rate
    audioRate=$((rateOut>rateInput ? rateInput : rateOut ))

    # Add merging audios
    audioArgs+=(
        -filter_complex amerge=inputs=2
    )
fi

# Audio rate args
audioRateArgs=()
if [ $audioRate != '' ]; then
    audioRateArgs+=(
        -ar "$audioRate"
    )
fi

# ===== Record screen ===== #
# ffmpeg command to record screen
ffmpeg "${audioArgs[@]}" -f x11grab -r "$fps" -s "$res" -i :0.0+"$coord" \
       "${audioRateArgs[@]}" "$outputVideo"
