# Determine the current theme from the state file (source of truth), not the
# environment, so this works from any terminal or from a waybar button.
CURRENT_THEME=$(cat ~/.local/share/.user_current_theme 2>/dev/null)

# Swap alacritty
if [[ "$CURRENT_THEME" == "dark" ]]; then
    CURRENT_THEME="light"

    # Alacritty
    ln -sf \
        ~/.config/alacritty/solarized-light.toml \
        ~/.config/alacritty/current-theme.toml

    # Tofi
    ln -sf \
        ~/.config/tofi/solarized-light.conf \
        ~/.config/tofi/current-theme.conf

    # NWG Shell for all other apps
    cp ~/.local/share/bin/assets/light-gsettings ~/.local/share/nwg-look/gsettings && \
        nwg-look -a

    # VSCode
    settingsTempFile=(tempfile)
    jq '.["workbench.colorTheme"] = "Solarized Light+"' ~/.config/Code/User/settings.json > $settingsTempFile
    mv $settingsTempFile ~/.config/Code/User/settings.json

else
    CURRENT_THEME="dark"

    # Alacritty
    ln -sf \
        ~/.config/alacritty/dracula.toml \
        ~/.config/alacritty/current-theme.toml

    # Tofi
    ln -sf \
        ~/.config/tofi/dracula.conf \
        ~/.config/tofi/current-theme.conf

    # NWG Shell for all other apps
    cp ~/.local/share/bin/assets/dark-gsettings ~/.local/share/nwg-look/gsettings && \
        nwg-look -a

    # VSCode
    settingsTempFile=(tempfile)
    jq '.["workbench.colorTheme"] = "Dracula Theme"' ~/.config/Code/User/settings.json > $settingsTempFile
    mv $settingsTempFile ~/.config/Code/User/settings.json
fi

echo $CURRENT_THEME > ~/.local/share/.user_current_theme

# Reload waybar so it picks up the new theme (launch script reads the file above)
~/.config/waybar/launch-waybar.sh
