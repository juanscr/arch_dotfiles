-- Detect dark/light mode from the theme selector used by this system.
local function is_dark_mode()
    local theme_handler = io.open(
        os.getenv("HOME") .. "/.local/share/.user_current_theme"
    )
    if not theme_handler then
        return true
    end

    local current_theme = theme_handler:read("*a")
    theme_handler:close()
    return current_theme:match("%S+") == "dark"
end

local function set_solarized_diff_highlights()
    local highlights

    if vim.o.background == "dark" then
        highlights = {
            DiffAdd = { fg = "#eee8d5", bg = "#365044" },
            DiffChange = { fg = "#eee8d5", bg = "#594a33" },
            DiffDelete = { fg = "#eee8d5", bg = "#603b3b" },
            DiffText = { fg = "#eee8d5", bg = "#544d75", bold = true },
        }
    else
        highlights = {
            DiffAdd = { fg = "#586e75", bg = "#e7edc5" },
            DiffChange = { fg = "#586e75", bg = "#f5e3bd" },
            DiffDelete = { fg = "#586e75", bg = "#f5d5d1" },
            DiffText = { fg = "#002b36", bg = "#ddd6ee", bold = true },
        }
    end

    for group, highlight in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, highlight)
    end

    local neogit_loaded, neogit_config = pcall(require, "neogit.config")
    if neogit_loaded then
        require("neogit.lib.hl").setup(neogit_config.values)
    end
end

-- Set theme and transparency
function SetColorScheme(color)
    if not color then
        if is_dark_mode() then
            color = "dracula"
            vim.opt.background = "dark"
        else
            color = "solarized"
            vim.opt.background = "light"
        end
    end

    vim.cmd.colorscheme(color)
    if color == "solarized" then
        set_solarized_diff_highlights()
    end
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

if not vim.g.vscode then
    vim.g.solarized_disable_background = true
    SetColorScheme()

    -- Auto-switch theme every 5 seconds when OS mode changes.
    local timer = vim.uv.new_timer()
    timer:start(5000, 5000, vim.schedule_wrap(function()
        SetColorScheme()
    end))
end
