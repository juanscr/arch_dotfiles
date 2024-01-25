# Swap alacritty
if [[ "$CURRENT_THEME" == "dark" ]]; then
    export CURRENT_THEME="light"

    # Alacritty
    ln -sf \
        ~/.config/alacritty/solarized-light.toml \
        ~/.config/alacritty/current-theme.toml

    # Nvim
    /usr/bin/nvim \
        --server /tmp/nvim.pipe \
        --remote-send ':lua SetColorScheme("solarized")<CR>'
else
    export CURRENT_THEME="dark"

    # Alacritty
    ln -sf \
        ~/.config/alacritty/dracula.toml \
        ~/.config/alacritty/current-theme.toml

    # Nvim
    /usr/bin/nvim \
        --server /tmp/nvim.pipe \
        --remote-send ':lua SetColorScheme("dracula")<CR>'
fi

echo $CURRENT_THEME > ~/.local/share/.user_current_theme
