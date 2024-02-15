-- Set theme and transparency
function SetColorScheme(color)
    local default_color = "dracula"
    local theme_handler = io.open(
        os.getenv("HOME").."/.local/share/.user_current_theme"
    )
    if theme_handler ~= nil then
        local current_theme = theme_handler:read()
        theme_handler:close()
        if current_theme == "dark" then
            default_color = "dracula"
        else
            default_color = "solarized"
        end
    end
    color = color or default_color
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.g.solarized_disable_background = true
SetColorScheme()
