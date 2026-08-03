-- ===============================================
--
--
--            Hyprland config
--
-- ===============================================

-- ========== Input configuration ==========
require("input")

-- ========== Monitors configuration (autorandr like) ==========
require("monitor")

-- ========== Variables ==========
local mainMod = "SUPER"
local terminal = "~/.local/share/bin/launchers/launch-terminal.sh"
local browser = "firefox"

-- ========== Basic behavior ==========
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Lock screen
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprlock"))

-- Exit Hyprland
local exitMode = "exit: [l]ogout [r]eboot [p]oweroff"

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.submap(exitMode))
hl.define_submap(exitMode, function()
    hl.bind("l", hl.dsp.exit())
    hl.bind("r", hl.dsp.exec_cmd("systemctl reboot"))
    hl.bind("p", hl.dsp.exec_cmd("systemctl poweroff"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Search and run app
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("tofi-run | xargs hyprctl dispatch exec --"))

-- ========== Media controls ==========
-- Volume control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))

-- Brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("sudo xbacklight -inc 10"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("sudo xbacklight -dec 10"))

-- Media player controls
local playerctl = "playerctl -p spotify,%any"

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(playerctl .. " play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(playerctl .. " next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(playerctl .. " previous"))
hl.bind(mainMod .. " + right", hl.dsp.exec_cmd(playerctl .. " next"))
hl.bind(mainMod .. " + left", hl.dsp.exec_cmd(playerctl .. " previous"))

-- ========== Window movement ==========
local directions = {
    H = { focus = "left",  move = "l" },
    K = { focus = "up",    move = "u" },
    J = { focus = "down",  move = "d" },
    L = { focus = "right", move = "r" },
}

for key, direction in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction.focus }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction.move }))
end

-- Resize
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window modifiers
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + CONTROL + SPACE", hl.dsp.window.move({ workspace = "special:magic" }))

-- Focus monitor
hl.bind(mainMod .. " + W", hl.dsp.focus({ monitor = 1 }))
hl.bind(mainMod .. " + E", hl.dsp.focus({ monitor = 0 }))

-- Tabbed layout
hl.bind(mainMod .. " + TAB", hl.dsp.group.toggle())

-- ========== Workspace movement ==========
for workspace = 1, 9 do
    local key = tostring(workspace)

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = workspace, on_current_monitor = true })
    )
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = workspace })
    )
    hl.workspace_rule({
        workspace = key,
        persistent = true,
    })
end

-- ========== Gaps and look ==========
hl.config({
    general = {
        gaps_in = 10,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgb(BD93F9)", "rgb(6272A4)" },
                angle = 45,
            },
            inactive_border = "rgb(44475A)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "master",
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = false,
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },

    animations = {
        enabled = false,
    },

    master = {
        orientation = "right",
        mfact = 0.5,
    },
})

-- ========== Environment variables ==========
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ========== Application keybinds ==========
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify-launcher"))

local applications = {
    {
        keypad = "KP_Insert",
        modeKey = "0",
        command = terminal .. " --class OpenfortiVPN,OpenfortiVPN -e ~/.local/share/bin/launchers/launch-vpn.sh",
    },
    {
        keypad = "KP_End",
        modeKey = "1",
        command = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland",
    },
    {
        keypad = "KP_Down",
        modeKey = "2",
        command = "signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland",
    },
    { keypad = "KP_Next",  modeKey = "3", command = "pavucontrol" },
    { keypad = "KP_Left",  modeKey = "4", command = "bitwarden-desktop" },
    { keypad = "KP_Begin", modeKey = "5", command = "Telegram" },
}

for _, application in ipairs(applications) do
    hl.bind(mainMod .. " + " .. application.keypad, hl.dsp.exec_cmd(application.command))
end

-- Mode for launching the same keypad applications with number keys
local appMode = "Launch app"

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.submap(appMode))
hl.define_submap(appMode, function()
    for _, application in ipairs(applications) do
        hl.bind(application.modeKey, function()
            hl.exec_cmd(application.command)
            hl.dispatch(hl.dsp.submap("reset"))
        end)
    end

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Screenshot manager
hl.bind("Print", hl.dsp.exec_cmd("grimshot copy active"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grimshot copy area"))
hl.bind("CONTROL + Print", hl.dsp.exec_cmd("grimshot copy screen"))

-- ========== Window rules ==========
require("window_rules")

-- ========== Autostart ==========
require("autostart")
