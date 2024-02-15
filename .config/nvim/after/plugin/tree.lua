local api = require("nvim-tree.api")

function on_attach(bufnr)
    local function opts(desc)
        return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    -- Tree operations
    vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('Change node'))
    vim.keymap.set("n", "h", api.tree.toggle_hidden_filter, opts("Hidden Files"))

    -- File operations
    vim.keymap.set("n", "fc", api.fs.create, opts("Create file"))
    vim.keymap.set("n", "fr", api.fs.rename, opts("Rename"))
    vim.keymap.set('n', 'fp', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'fy', api.fs.cut, opts('Copy Name'))
    vim.keymap.set('n', 'fdd', api.fs.remove, opts('Remove file'))

    -- Node operations
    vim.keymap.set('n', '<CR>',  api.node.open.edit, opts("Open"))
    vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit, opts('Open'))
end

-- Tree setup
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
      git_ignored = false,
    },
    on_attach = on_attach,
    update_focused_file = {
        enable = true,
        update_root = true
    },
    sync_root_with_cwd = false,
    respect_buf_cwd = false,
})

-- Open and close tree
vim.keymap.set("n", "<leader>to", api.tree.open)
vim.keymap.set("n", "<leader>tc", api.tree.close)

-- Quit tree when quitting
vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
})
