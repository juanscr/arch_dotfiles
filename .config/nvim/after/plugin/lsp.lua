lsp_keys = {
    definition = "<leader>ldo",
    hover = "<leader>lh",
    peek = "<leader>lp",
    goToNext = "<leader>len",
    goToPrev = "<leader>lep",
    rename = "<leader>lcn",
    references = "<leader>lro"
}

function setup_lsp()
    -- LSP configuration
    local lsp = require('lsp-zero')

    -- Telescope for references
    local builtin = require('telescope.builtin')

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
        vim.keymap.set("n", lsp_keys.definition, function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", lsp_keys.hover, function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", lsp_keys.goToNext, function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", lsp_keys.goToPrev, function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", lsp_keys.rename, function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', lsp_keys.references, builtin.lsp_references, {})
    end)

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
end

function setup_lsp_vscode()
    local vscode = require('vscode')
    vim.keymap.set("n", lsp_keys.definition, function() vscode.action("editor.action.revealDefinition") end)
    vim.keymap.set("n", lsp_keys.rename, function() vscode.action("editor.action.rename") end)
    vim.keymap.set("n", lsp_keys.hover, function() vscode.action("editor.action.showHover") end, opts)
    vim.keymap.set('n', lsp_keys.references, function() vscode.action("editor.action.goToReferences") end, {})
    vim.keymap.set('n', lsp_keys.peek, function() vscode.action("editor.action.peekDefinition") end, {})
    vim.keymap.set('n', lsp_keys.goToNext, function() vscode.action("editor.action.marker.next") end, {})
    vim.keymap.set('n', lsp_keys.goToPrev, function() vscode.action("editor.action.marker.prev") end, {})
end

if not vim.g.vscode then
    setup_lsp()
else
    setup_lsp_vscode()
end
