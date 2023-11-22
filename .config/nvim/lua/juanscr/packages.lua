-- Packer installation
vim.cmd [[packadd packer.nvim]]

-- Packages dependencies
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Dracula theme
    use 'Mofiqul/dracula.nvim'

    -- Solarized theme
    use 'shaunsingh/solarized.nvim'

    -- Improve coloring of source code
    use {
          'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate'
    }

    -- File explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require("nvim-tree").setup {}
        end
    }

    -- LSP Configuration
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},             -- Required
                {'williamboman/mason.nvim'},           -- Optional
                {'williamboman/mason-lspconfig.nvim'}, -- Optional

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},     -- Required
                {'hrsh7th/cmp-nvim-lsp'}, -- Required
                {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    -- Magit similar
    use {
        'NeogitOrg/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        config = true
    }
end)
