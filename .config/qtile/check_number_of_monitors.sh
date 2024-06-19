if [[ `echo "$XDG_SESSION_TYPE"` == "x11" ]]; then
    "$HOME"/.config/qtile/monitor_scripts/x11.sh;
    exit 0;
fi
"$HOME"/.config/qtile/monitor_scripts/wayland.sh;
