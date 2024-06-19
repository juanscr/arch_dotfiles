#!/usr/bin/sh

# Screen, background and conky
autorandr --change --force &

# Compositor
picom &

# Tray icons
flameshot &
nm-applet &
discord &

# Browser
chromium &

# Terminal
"$HOME"/.local/share/bin/launchers/launch-terminal.sh &

# Aesthetics
xrdb "$HOME"/.config/X11/Xresources &

# Notification daemon
dunst &

# File manager
pcmanfm &

# Applet
blueman-applet &

# Polkit authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Autorun telegram
hostname=$(hostnamectl hostname)
if [ $hostname = "dell-juanscr" ]; then
    telegram-desktop &
fi

# Set flags for spotify launcher
if [[ `echo "$XDG_SESSION_TYPE"` == "x11" ]]; then
    rm ~/.config/spotify-launcher.conf
else
    echo "[spotify]
extra_arguments = [\"--enable-features=UseOzonePlatform\", \"--ozone-platform=wayland\"]" \
    > ~/.config/spotify-launcher.conf
fi
