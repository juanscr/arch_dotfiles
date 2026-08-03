-- Normal monitor setup (laptop only)
hl.monitor({
    output = "eDP-1",
    mode = "highres",
    position = "0x0",
    scale = 1,
})

-- MS Home setup resolution
hl.monitor({
    output = "desc:Lenovo Group Limited T27p-30 V5RCF118",
    mode = "highres",
    position = "1920x-640",
    scale = 1.5,
})

-- Setup TV
hl.monitor({
    output = "desc:Samsung Electric Company SAMSUNG 0x01000E00",
    mode = "highres",
    position = "auto-left",
    scale = 2,
})

-- Setup LG TV
hl.monitor({
    output = "desc:LG Electronics LG TV 0x01010101",
    mode = "highres",
    position = "auto-up",
    scale = 1,
})

-- Setup LG monitor
hl.monitor({
    output = "desc:LG Electronics LG ULTRAGEAR 408NTKF0P941",
    mode = "2560x1440",
    position = "auto-right",
    scale = 1,
})

-- Default settings for unknown monitors
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
    bitdepth = 10,
})
