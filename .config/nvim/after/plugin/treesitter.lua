function setup_treesitter()
    require 'nvim-treesitter.install'.prefer_git = false
    require 'nvim-treesitter.install'.compilers = { "zig" }

    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
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
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
    }
end

if not vim.g.vscode then
    setup_treesitter()
end
