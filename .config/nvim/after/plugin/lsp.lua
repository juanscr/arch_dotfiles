-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select)
})
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
        buffer = bufnr,
        omit = {'K'}
    })

    local opts = {buffer=bufnr, remap = false}
    vim.keymap.set("n", "<leader>gtd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>gtn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>gtp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>gtr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, opts)
end)

-- Format on Save
lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['pyright'] = {'python'},
  }
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
