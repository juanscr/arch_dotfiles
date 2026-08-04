-- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    -- Dracula theme
    {
        'Mofiqul/dracula.nvim',
        cond = not vim.g.vscode
    },

    -- Solarized theme
    {
        'shaunsingh/solarized.nvim',
        cond = not vim.g.vscode
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'main',
        build = ':TSUpdate',
        cond = not vim.g.vscode,
        lazy = false
    },

    -- LSP Zero configuration
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        cond = not vim.g.vscode
    },
    {
        'neovim/nvim-lspconfig',
        cond = not vim.g.vscode
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        cond = not vim.g.vscode
    },
    {
        'hrsh7th/nvim-cmp',
        cond = not vim.g.vscode
    },
    {
        'L3MON4D3/LuaSnip',
        cond = not vim.g.vscode
    },
    {
        'williamboman/mason.nvim',
        cond = not vim.g.vscode
    },
    {
        'williamboman/mason-lspconfig.nvim',
        cond = not vim.g.vscode
    },

    -- Fuzy Finder
    {
        'nvim-telescope/telescope.nvim',
        branch = 'master',
        cond = not vim.g.vscode,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        }
    },

    -- Icons for files
    {
        'nvim-tree/nvim-web-devicons',
        cond = not vim.g.vscode
    },

    -- Magit alike
    {
        "NeogitOrg/neogit",
        cond = not vim.g.vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim" -- optional
            --"ibhagwan/fzf-lua",            -- optional
        },
        config = true
    },

    -- Automatically detect indentation
    "nmac427/guess-indent.nvim",

    -- Format files with specific tools
    {
        'stevearc/conform.nvim',
        cond = not vim.g.vscode,
        opts = {},
    },

    -- Harpoon!
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
})
