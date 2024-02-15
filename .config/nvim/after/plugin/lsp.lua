-- LSP configuration
local lsp = require('lsp-zero')

-- Autocompletion settings
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select)
    })
})

-- Keybinds
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
        buffer = bufnr,
        omit = {'K'}
    })

    local opts = {buffer=bufnr, remap = false}
    vim.keymap.set("n", "<leader>lod", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>lor", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ldn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>ldp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ldo", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>lcn", function() vim.lsp.buf.rename() end, opts)
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

-- Automatic installation of lsp servers
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "rust_analyzer",
        "pyright",
        "bashls",
        "dockerls",
        "eslint",
        "html",
        "jsonls",
        "tsserver",
        "tailwindcss",
        "taplo",
        "texlab",
        "sqlls",
        "volar",
        "yamlls"
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})
