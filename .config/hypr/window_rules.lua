hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

local workspaceRules = {
    [1] = {
        { class = "chromium" },
        { class = "librewolf" },
        { class = "firefox" },
    },
    [2] = {
        { class = "Alacritty" },
    },
    [3] = {
        { class = "org.inkscape.Inkscape" },
        { class = "org.pwmt.zathura" },
        { class = "org.kde.okular" },
        { class = "libreoffice-(.*)" },
        { class = "pcmanfm" },
        { class = "com.github.xournalpp.xournalpp" },
    },
    [4] = {
        { class = "code" },
    },
    [5] = {
        { class = "discord" },
        { class = "org.telegram.desktop" },
        { class = "(s|S)ignal" },
    },
    [6] = {
        { class = "vlc" },
        { class = "(.*)rn-Tim(.*)" },
    },
    [7] = {
        { class = "org.pulseaudio.pavucontrol" },
        { class = "nwg-look" },
        { class = "com.github.FontManager.FontManager" },
        { class = "qt5ct" },
        { class = "qt6ct" },
        { class = "OpenfortiVPN" },
        { title = "D(b|B)eaver(.*)" },
    },
    [8] = {
        { title = "Spotify Premium" },
    },
}

for workspace, matches in pairs(workspaceRules) do
    for index, match in ipairs(matches) do
        hl.window_rule({
            name = "workspace-" .. workspace .. "-" .. index,
            match = match,
            workspace = tostring(workspace),
        })
    end
end

hl.window_rule({
    name = "float-portal-dialog",
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)",
    center = true,
})

hl.window_rule({
    name = "float-blueman-manager",
    match = { class = "blueman-manager" },
    float = true,
})
