function setup_telescope()
    local builtin = require('telescope.builtin')

    -- File change
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
    vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
end

if not vim.g.vscode then
    setup_telescope()
end
