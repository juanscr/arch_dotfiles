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
