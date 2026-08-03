hl.config({
    input = {
        -- Keyboard configuration
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_model = "evdev",
        kb_options = "caps:swapescape",

        -- Mouse sensitivity
        follow_mouse = 1,
        sensitivity = 0,

        -- Touchpad actions
        touchpad = {
            tap_button_map = "lrm",
            natural_scroll = true,
            tap_to_click = true,
            drag_3fg = 1,
        },
    },
})
