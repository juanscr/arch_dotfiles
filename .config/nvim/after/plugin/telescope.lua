function setup_telescope()
    local format_path = function(opts, path)
        local path_object = require('plenary.path'):new(path)
        local display_path = path_object:is_absolute()
            and path_object:make_relative(opts.cwd or vim.uv.cwd())
            or path
        local separator = display_path:find("\\", 1, true) and "\\" or "/"
        local components = vim.split(display_path, separator, {plain = true})
        local filename = table.remove(components)

        for index = 1, #components - 2 do
            components[index] = components[index]:sub(1, 1)
        end

        if #components == 0 then
            return filename
        end

        return filename .. "  " .. table.concat(components, separator)
    end

    require('telescope').setup({
        pickers = {
            find_files = {
                hidden = true,
                path_display = format_path,
            },
            git_files = {
                path_display = format_path,
            },
        },
    })
    local builtin = require('telescope.builtin')

    -- File change
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
    vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
end

if not vim.g.vscode then
    setup_telescope()
end
