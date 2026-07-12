local ensure_installed = {
    "c",
    "javascript",
    "typescript",
    "bash",
    "css",
    "dockerfile",
    "graphql",
    "json",
    "python",
    "rust",
    "scss",
    "toml",
    "yaml",
    "lua",
    "vim",
    "markdown"
}

function setup_treesitter()
    require 'nvim-treesitter.install'.compilers = { "gcc", "cc", "zig" }
    require 'nvim-treesitter'.install(ensure_installed)

    -- Enable highlighting automatically for any buffer that has a parser
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
            local ok = pcall(vim.treesitter.start, args.buf)
            if ok then
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
        end,
    })
end

if not vim.g.vscode then
    setup_treesitter()
end
