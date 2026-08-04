function setup_neogit()
    local neogit = require('neogit')
    neogit.setup {}

    local function set_solarized_delete_highlights()
        if vim.g.colors_name ~= "solarized" then
            return
        end

        local highlights
        if vim.o.background == "dark" then
            highlights = {
                NeogitDiffAdd = { fg = "#eee8d5", bg = "#365044" },
                NeogitDiffAddHighlight = { fg = "#c7da7e", bg = "#365044" },
                NeogitDiffAddInline = { fg = "#eee8d5", bg = "#4b6a58", bold = true },
                NeogitDiffAddCursor = { fg = "#c7da7e", bg = "#073642" },
                NeogitDiffDelete = { fg = "#eee8d5", bg = "#603b3b" },
                NeogitDiffDeleteHighlight = { fg = "#ff9f9a", bg = "#603b3b" },
                NeogitDiffDeleteInline = { fg = "#eee8d5", bg = "#804b4b", bold = true },
                NeogitDiffDeleteCursor = { fg = "#ff9f9a", bg = "#073642" },
            }
        else
            highlights = {
                NeogitDiffAdd = { fg = "#586e75", bg = "#e7edc5" },
                NeogitDiffAddHighlight = { fg = "#859900", bg = "#e7edc5" },
                NeogitDiffAddInline = { fg = "#586e75", bg = "#d3dd99", bold = true },
                NeogitDiffAddCursor = { fg = "#859900", bg = "#eee8d5" },
                NeogitDiffDelete = { fg = "#586e75", bg = "#f5d5d1" },
                NeogitDiffDeleteHighlight = { fg = "#dc322f", bg = "#f5d5d1" },
                NeogitDiffDeleteInline = { fg = "#586e75", bg = "#efc3bd", bold = true },
                NeogitDiffDeleteCursor = { fg = "#dc322f", bg = "#eee8d5" },
            }
        end

        for group, highlight in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, highlight)
        end
    end

    set_solarized_delete_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_solarized_delete_highlights,
    })

    vim.keymap.set('n', '<leader>gg', neogit.open)
end

if not vim.g.vscode then
    setup_neogit()
end
