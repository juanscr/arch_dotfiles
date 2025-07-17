#!/usr/bin/sh

function launchApps() {
    if [[ `echo "$XDG_SESSION_TYPE"` == "x11" ]]; then
        launchX11Apps &
        return;
    fi

    launchWaylandApps &
}

function launchX11Apps() {
    # Screen, background and conky
    autorandr --change --force &

    # Compositor
    picom &

    # Tray icons
    flameshot &

    # Aesthetics
    xrdb "$HOME"/.config/X11/Xresources &

    # Spotify launchar flags
    rm ~/.config/spotify-launcher.conf
}

function launchWaylandApps() {
    # Spotify launcher
    echo "[spotify]
extra_arguments = [\"--enable-features=UseOzonePlatform\", \"--ozone-platform=wayland\"]" \
    > ~/.config/spotify-launcher.conf
}


# Tray icons
nm-applet &

# Browser
firefox &

# Terminal
"$HOME"/.local/share/bin/launchers/launch-terminal.sh &

# Notification daemon
dunst &

# File manager
pcmanfm &

# Applet
blueman-applet &

# Polkit authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Autorun telegram
telegram-desktop &

# Launch other applications depending on environment
launchApps &
