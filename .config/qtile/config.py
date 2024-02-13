# =============================================== #
#                                                 #
#                                                 #
#              qtile 0.23.0 config                #
#                                                 #
# =============================================== #

import re
import subprocess
from os.path import expanduser as eu

from libqtile import bar, hook
from libqtile.backend.base import Window
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.layout.floating import Floating
from libqtile.layout.stack import Stack
from libqtile.layout.xmonad import MonadTall
from libqtile.lazy import lazy

from my_widgets import MyWidgets

# Mod key
mod = "mod4"

# Browser
browser = "chromium"

# Local binaries path
local_bin = eu("~/.local/share/bin")

# Terminal
terminal = f"{local_bin}/launchers/launch-terminal.sh"

# ============ Basic Behavior ============
keys = [
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload config qtile"),
    Key([mod, "control", "shift"], "r", lazy.reload_config(), desc="Reload config qtile"),
    # Lock screen
    Key(
        [mod, "shift"], "x", lazy.spawn("betterlockscreen -l blur"), desc="Lock screen."
    ),
    # Exit qtile
    KeyChord(
        [mod, "shift"],
        "e",
        [
            Key([], "l", lazy.shutdown(), desc="Log off"),
            Key([], "r", lazy.spawn("systemctl reboot"), desc="Reboot PC"),
            Key([], "p", lazy.spawn("systemctl poweroff"), desc="Shutdown"),
        ],
        name="exit: [l]ogout, [r]eboot, [p]oweroff",
    ),
    # Search for app. Customized to use dracula theme.
    # Tested with dmenu 5.0
    Key([mod], "d", lazy.spawn("dmenu_run"), desc="Spawn dmenu"),
    # Select monitor layout
    Key(
        [mod, "shift"],
        "a",
        lazy.spawn(f"{local_bin}/select-monitor.sh"),
        desc="Select monitor layout using script",
    ),
]

# ============ Media Controls ============
playerctl = "playerctl -p spotify,%any"
keys += [
    # Volume control
    # Tested with pamixer 1.4.5
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t"), desc="Toggle mute."),
    # Brightness control
    # Tested with light 1.2
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 10"),
        desc="Increase brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 10"),
        desc="Decrease brightness",
    ),
    # Media player controls
    # Used with https://bit.ly/3hAVW5x
    Key(
        [],
        "XF86AudioPlay",
        lazy.spawn(f"{playerctl} play-pause"),
        desc="Play or pause spotify",
    ),
    Key([], "XF86AudioNext", lazy.spawn(f"{playerctl} next"), desc="Next song spotify"),
    Key(
        [],
        "XF86AudioPrev",
        lazy.spawn(f"{playerctl} previous"),
        desc="Previous song spotify",
    ),
    Key(
        [mod], "p", lazy.spawn(f"{playerctl} play-pause"), desc="Play or pause spotify"
    ),
    Key([mod], "Right", lazy.spawn(f"{playerctl} next"), desc="Next song spotify"),
    Key(
        [mod],
        "Left",
        lazy.spawn(f"{playerctl} previous"),
        desc="Previous song spotify",
    ),
]

# ========== Window movement ========== #
keys += [
    # Change focus between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    # Move window
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    # Resize windows
    Key([mod, "control"], "j", lazy.layout.shrink(), desc="Decrease window size"),
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Increase window size"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # Orientation of workspace
    Key([mod], "v", lazy.layout.flip(), desc="Flip layout"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Fullscreen"),
    # Floating mode
    Key([mod, "shift"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
    # Movement between screens
    Key([mod], "w", lazy.to_screen(0), desc="Switch to screen 0."),
    Key([mod], "e", lazy.to_screen(1), desc="Switch to screen 1."),
]

# ========== Workspace configuration ==========
# Workspaces names, keybinds and default layouts
workspaces = [
    ["1", {"label": "", "layout": "stack"}],
    ["2", {"label": "", "layout": "monadtall"}],
    ["3", {"label": "", "layout": "stack"}],
    ["4", {"label": "", "layout": "monadtall"}],
    ["5", {"label": "", "layout": "stack"}],
    ["6", {"label": "", "layout": "stack"}],
    ["7", {"label": "", "layout": "stack"}],
    ["8", {"label": "", "layout": "stack"}],
]

# Apps default workspace
ws = lambda index: workspaces[index - 1][0]
OPENFORTIVPN = "OpenfortiVPN"
force_match = {
    "gephi": Match(wm_class="Gephi 0.9.2"),
    "gephi_start": Match(title="Starting Gephi 0.9.2"),
    "spotify": Match(wm_class="Spotify"),
    "spotify_title": Match(title="Spotify"),
    "lis_cobol": Match(wm_class="com-iscobol-gui-client-Client"),
}
matches = {
    # Browser
    ws(1): [
        Match(wm_class="firefox"),
        Match(wm_class="Brave-browser"),
        Match(wm_class="Chromium"),
        ],
    # Terminal and text editors
    ws(2): [
        Match(wm_class="Emacs"),
        Match(wm_class="st-256color"),
        Match(wm_class="kitty"),
        Match(wm_class="Alacritty"),
        Match(title=re.compile("^synthwave"), wm_class="mpv")
    ],
    # Viewers and media editors
    ws(3): [
        Match(wm_class="Inkscape"),
        Match(title="LibreOffice"),
        Match(wm_class="libreoffice-calc"),
        Match(wm_class="libreoffice-writer$"),
        Match(wm_class="Soffice"),
        Match(wm_class="okular"),
        Match(wm_class="Zathura"),
        Match(wm_class="Gimp"),
        Match(wm_class="Pcmanfm"),
        force_match["gephi"],
        force_match["gephi_start"],
    ],
    # IDEs
    ws(4): [
        Match(wm_class="jetbrains-pycharm-ce"),
        Match(wm_class="jetbrains-idea-ce"),
        Match(wm_class="Eclipse"),
        Match(wm_class="Lunacy"),
        Match(wm_class="Code"),
        force_match["lis_cobol"],
    ],
    # Social
    ws(5): [
        Match(wm_class="discord"),
        Match(wm_class="Microsoft Teams - Preview"),
        Match(wm_class="Slack"),
        Match(wm_class="zoom"),
        Match(wm_class="whatsapp-nativefier-d40211"),
        Match(wm_class="TelegramDesktop"),
        Match(wm_class="Signal"),
    ],
    # Media
    ws(6): [
        Match(wm_class="Popcorn-Time"),
        Match(wm_class="Stremio"),
        Match(wm_class="vlc"),
        Match(wm_class="qBittorrent"),
        Match(title="Steam"),
        Match(wm_class="steam"),
    ],
    # Configuration apps
    ws(7): [
        Match(wm_class="Arandr"),
        Match(wm_class="Pavucontrol"),
        Match(wm_class="Lxappearance"),
        Match(wm_class="Lightdm-settings"),
        Match(wm_class="Font-manager"),
        Match(wm_class="Nvidia-settings"),
        Match(wm_class="Bitwarden"),
        Match(wm_class="qt5ct"),
        Match(wm_class="v4l2ucp"),
        Match(wm_class="beekeeper-studio"),
        Match(wm_class=OPENFORTIVPN),
        Match(wm_class="org.remmina.Remmina"),
        Match(wm_class="DBeaver"),
        Match(wm_class="java-lang-Thread"),
    ],
    # Background apps
    ws(8): [
        force_match["spotify"],
        force_match["spotify_title"],
        Match(wm_class="youtube-music-desktop-app"),
    ],
}

# _____ Add matches to groups _____ #
for index in range(len(workspaces)):
    if ws(index + 1) in matches:
        workspaces[index][1]["matches"] = matches[ws(index + 1)]

# _____ Create groups _____ #
groups = [Group(name, **kwargs) for name, kwargs in workspaces]

for g in groups:
    keys += [
        # Keybinds for wokspace
        Key(
            [mod],
            g.name,
            lazy.group[g.name].toscreen(toggle=False),
            desc="Switch to group {}".format(g.label),
        ),
        # Move windows to workspace
        Key(
            [mod, "control"],
            g.name,
            lazy.window.togroup(g.name),
            desc="Move focused window to group {}".format(g.name),
        ),
        # Move windows to workspace
        Key(
            [mod, "shift"],
            g.name,
            lazy.window.togroup(g.name, switch_group=True),
            desc="Switch to and move focused window to group {}".format(g.name),
        ),
    ]

# ========== Gaps configuration ========== #
# Borders size
border = 2

# Gaps
gaps = 10

# ========== Application behavior ========== #
# _____ Add keybinds for keypads _____ #
keypads = [
    (
        "KP_Insert",
        f"{terminal} --class {OPENFORTIVPN},{OPENFORTIVPN} "
        + f"-e {local_bin}/launchers/launch-vpn.sh",
        "FortiVPN",
    ),
    ("KP_End", "discord"),
    ("KP_Down", "arandr"),
    ("KP_Next", "pavucontrol"),
    ("KP_Left", "bitwarden-desktop"),
    ("KP_Begin", "dbeaver"),
    ("KP_Right", f"{local_bin}/launchers/launch-steam.sh"),
    ("KP_Home", "slack"),
    ("KP_Up",),
    ("KP_Prior",),
]
keypads_keys = [
    Key([mod, "shift"], keypad[0], lazy.spawn(keypad[1]))
    for keypad in keypads
    if len(keypad) > 1
]
keypads_chord = KeyChord(
    [mod, "shift"],
    "s",
    [
        Key([], str(index), lazy.spawn(keypad[1]))
        for index, keypad in enumerate(keypads)
        if len(keypad) > 1
    ],
    name="Use numbers for keypad keybindings.",
)

# Application openers
keys += [
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "s", lazy.spawn("spotify-launcher"), desc="Launch spotify"),
    Key(
        [mod],
        "z",
        lazy.spawn(
            "mpv --cache=no " +
            "https://www.youtube.com/live/4xDzrJKXOOY?si=jFYI1lISG7iCN2Q1"
        ),
        desc="Launch spotify"
    ),
    Key([mod], "i", lazy.spawn(browser), desc="Launch browser"),
    *keypads_keys,
    keypads_chord,
]

# Screenshots manager
# Tested with flameshot v0.9.0
keys += [
    Key(
        [],
        "Print",
        lazy.spawn(f"{local_bin}/screenshot.sh"),
        desc="Take screenshot of focused monitor",
    ),
    Key(
        [mod],
        "Print",
        lazy.spawn("flameshot gui"),
        desc="Take screenshot with flameshot's GUI",
    ),
    Key(
        ["control"],
        "Print",
        lazy.spawn("flameshot full -c -p " + eu("~/pictures/screenshots")),
        desc="Take screenshot of all screens",
    ),
]


# ========== Aesthetics ========= #
# _____ Function for obtaining the number of monitors _____ #
def get_number_of_monitors() -> int:
    """It gets the number of monitors.

    Returns
    -------
    int
        The number of active non-mirrored monitors.
    """

    try:
        output = subprocess.check_output(
            eu("~/.config/qtile/check_number_of_monitors.sh"), shell=True
        ).decode()[:-1]
    except subprocess.SubprocessError:
        return 0

    return int(output)


n_monitor = get_number_of_monitors()

# Dracula theme for windows
border_focused = "#6272A4"
border_unfocused = "#282A36"

# Dracula theme for bar
colors = {
    "background": "#282A36",
    "background-alt1": "#44475A",
    "foreground": "#F8F8F2",
    "foreground-alt": "#BFBFBF",
    "foreground-alt1": "#6272A4",
    "red": "#FF5555",
    "green": "#50FA7B",
    "yellow": "#F1FA8C",
    "blue": "#BD93D9",
    "magenta": "#FF79C6",
    "cyan": "#8BE9FD",
    "orange": "#FFB86C",
}

# Widget settings
fonts = {
    "Normal": {"font": "JetBrains Mono", "fontsize": 12},
    "Icons": {"font": "JetBrainsMono Nerd Font Mono", "fontsize": 24},
    "Icons2": {"font": "JetBrainsMono Nerd Font", "fontsize": 16},
}

# Bar sizes
heights = {"bar1": 30, "bar2": 30}

# Padding
padding_left = {"bar1": 0, "bar2": 0}
padding_right = {"bar1": 15, "bar2": 15}

# Widgets class
mw = MyWidgets(colors, fonts, padding_left, padding_right)


# Bar for my first screen
def my_bar1():
    widgets_left = [*mw.widget_groups(), *mw.widget_chord()]
    widgets_center = [*mw.widget_time(add_pipe=False)]
    widgets_right = [
        *mw.widget_spotify(),
        *mw.widget_volume(),
        *mw.widget_layout(),
        *mw.widget_update(),
        *mw.widget_battery(),
        *mw.widget_tray(),
    ]
    widgets = mw.create_widgets(widgets_left, widgets_center, widgets_right, 1)

    # Height of bar
    size = heights["bar1"]

    # Background
    background = colors["background"]

    return {"widgets": widgets, "size": size, "background": background}


# Bar for my second screen
def my_bar2():
    widgets_left = [*mw.widget_groups(mirror=False), *mw.widget_chord()]
    widgets_center = [*mw.widget_time(add_pipe=False)]
    widgets_right = [*mw.widget_cpu(), *mw.widget_ram(), *mw.widget_brightness()]
    widgets = mw.create_widgets(widgets_left, widgets_center, widgets_right, 2)

    # Height of bar
    size = heights["bar2"]

    # Background
    background = colors["background"]

    return {"widgets": widgets, "size": size, "background": background}


# Bar for my only screen
def my_bar_full():
    system_info = [
        *mw.widget_cpu(background="background-alt1", text=True),
        *mw.widget_ram(background="background-alt1"),
        *mw.widget_brightness(background="background-alt1"),
    ]
    widgets_left = [*mw.widget_groups(), *mw.widget_chord()]
    widgets_center = []
    widgets_right = [
        *mw.widget_spotify(max_length=20),
        *mw.widget_volume(),
        *mw.widget_layout(),
        *mw.widget_update(),
        *mw.widget_battery(),
        *mw.widget_group(system_info),
        *mw.widget_time(compact=True),
        *mw.widget_tray(),
    ]
    widgets = mw.create_widgets(widgets_left, widgets_center, widgets_right, 1)

    # Height of bar
    size = heights["bar1"]

    # Background
    background = colors["background"]

    return {"widgets": widgets, "size": size, "background": background}


# _____ Spawn each bar _____ #
if n_monitor == 2:
    screens = [Screen(top=bar.Bar(**my_bar1())), Screen(top=bar.Bar(**my_bar2()))]
else:
    screens = [Screen(top=bar.Bar(**my_bar_full()))]

# ========== Mouse Behavior ========== #
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# Change focus with mouse
follow_mouse_focus = True

# Focus window
focus_on_window_activation = "smart"

# Other
bring_front_click = False
cursor_warp = False
auto_fullscreen = True


# ========== Layouts ========== #
# _____ Configuring themes based on previous variables _____ #
layout_theme_tall = {
    "margin": gaps,
    "border_focus": border_focused,
    "border_normal": border_unfocused,
    "border_width": border,
    "align": MonadTall._right,
    "single_border_width": 0,
}
layout_theme_stack = {"margin": gaps, "num_stacks": 1, "border_width": 0}
layout_theme_float = {
    "border_focus": border_focused,
    "border_normal": border_unfocused,
    "border_width": border,
}

# Available layouts
layouts = [MonadTall(**layout_theme_tall), Stack(**layout_theme_stack)]
zoom_rules = [
    Match(wm_class="zoom", title="Settings"),
    Match(wm_class="zoom", title="Choose ONE of the audio conference options"),
    Match(wm_class="zoom", title=None),
]
dbeaver_not_main_window_name = re.compile("(?!DBeaver [0-9.]+ )")
middle_float = [
    Match(wm_type="dialog"),
    Match(title="win0", wm_class="jetbrains-idea-ce"),
    Match(wm_class="pomotroid"),
    Match(wm_class="Blueman-manager"),
    Match(wm_class="Blueman-services"),
    Match(wm_class="Nm-connection-editor"),
    Match(wm_class="DBeaver", title=dbeaver_not_main_window_name),
    Match(title="Steam", wm_class=""),
]
floating_layout = Floating(
    float_rules=[
        Match(wm_type="confirm"),
        Match(wm_type="download"),
        Match(wm_type="error"),
        Match(wm_type="file_progress"),
        Match(wm_type="notification"),
        Match(wm_type="splash"),
        Match(wm_type="toolbar"),
        Match(wm_type="confirmreset"),
        Match(wm_type="makebranch"),
        Match(wm_type="maketag"),
        Match(wm_type="notification"),
        Match(wm_type="utility"),
        Match(wm_type="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="meet.google.com is sharing your screen."),
        Match(wm_class="Pinentry-gtk-2"),
        Match(wm_class="Matplotlib"),
        Match(wm_class="flameshot", title="Configuration"),
        Match(wm_class="Inkscape", title="Preferences"),
        Match(wm_class="mpv", title=re.compile("^(?!synthwave)")),
        Match(wm_class="Nsxiv"),
        Match(wm_class="Options Editor"),
        Match(title="Close Firefox"),
        Match(wm_class="com-iscobol-gui-client-Client"),
        Match(title="Friends List", wm_class="steam"),
        Match(wm_class="Anydesk"),
        *zoom_rules,
        *middle_float,
    ],
    **layout_theme_float,
)


# ========== Hooks ========== #
# Automatic workspace for apps
@hook.subscribe.client_new
def default_workspaces(window: Window) -> None:
    for group in groups:
        if any(match.compare(window) for match in group.matches):
            window.togroup(group.name)
            break


# Startup all apps
@hook.subscribe.startup_once
def autostart() -> None:
    script = eu("~/.config/qtile/autostart.sh")
    subprocess.call([script])


# Force a workspace match
def force_match_default_workspace(window: Window) -> None:
    if any(match.compare(window) for match in force_match.values()):
        default_workspaces(window)


@hook.subscribe.client_managed
def manage_client(window: Window) -> None:
    force_match_default_workspace(window)


@hook.subscribe.client_name_updated
def manage_name_update(window: Window) -> None:
    force_match_default_workspace(window)


# Change size of floating windows
@hook.subscribe.client_new
def resize_floating_windows(window: Window) -> None:
    if any(rule.compare(window) for rule in middle_float):
        screen = window.qtile.current_screen
        if window.group is not None and window.group.screen is not None:
            screen = window.group.screen
        size = window.get_size()
        x, y = screen.x, screen.y
        window.set_position_floating(
            x + int((screen.width - size[0]) / 2),
            y + int((screen.height - size[1]) / 2),
        )


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
