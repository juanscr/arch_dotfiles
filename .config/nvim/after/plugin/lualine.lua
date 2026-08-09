function setup_lualine()
    require('lualine').setup({
        options = {
            theme = 'auto',
            globalstatus = true,
            component_separators = { left = ' ', right = ' ' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                {
                    'filename',
                    path = 1,
                },
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
    })
end

if not vim.g.vscode then
    setup_lualine()
end
