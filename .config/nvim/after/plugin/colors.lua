-- Set theme and transparency
function SetColorScheme(color)
    color = color or "solarized"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.g.solarized_disable_background = true
SetColorScheme()
