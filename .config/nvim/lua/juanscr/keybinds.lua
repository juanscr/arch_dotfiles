-- Leader
vim.g.mapleader = " "

-- Move files in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy and paste settings
vim.keymap.set("n", "<leader>cp", "\"+p")
vim.keymap.set("v", "<leader>cp", "\"+p")
vim.keymap.set("n", "<leader>cP", "\"+P")
vim.keymap.set("n", "<leader>cy", "\"+y")
vim.keymap.set("v", "<leader>cy", "\"+y")
vim.keymap.set("n", "<leader>cY", "\"+Y")

-- Non-function vscode keys
function window_movement_non_vscode()
    -- Move between windows
    vim.keymap.set("n", "<leader>w", "<C-w>")

    -- Explore directories
    vim.keymap.set("n", "<leader>fe", ":Explore<CR>")
end

function window_movement_vscode()
    local vscode = require('vscode')

    -- Close current tab
    vim.keymap.set("n", "<leader>wc", function()
      vscode.action("workbench.action.closeActiveEditor")
    end)

    -- Move to next tab
    vim.keymap.set("n", "<leader>wn", function()
      vscode.action("workbench.action.nextEditor")
    end)

    -- Move to previous tab
    vim.keymap.set("n", "<leader>wp", function()
      vscode.action("workbench.action.previousEditor")
    end)

    -- Focus terminal
    vim.keymap.set("n", "<leader>wt", function()
      vscode.action("workbench.action.terminal.focus")
    end)

    -- Focus the sidebar (Explorer, Source Control, etc.)
    vim.keymap.set("n", "<leader>we", function()
      vscode.action("workbench.action.focusSideBar")
    end)

    -- Fuzzy finding files
    vim.keymap.set('n', '<leader>ff', function()
      vscode.action('workbench.action.quickOpen')
    end)

    -- Split editor
    vim.keymap.set("n", "<leader>ws", function()
      vscode.action("workbench.action.splitEditorRight")
    end)

    -- Focus non-group split
    vim.keymap.set("n", "<leader>ww", function()
      vscode.action("workbench.action.focusNextGroup")
    end)

    -- Move window to other group
    vim.keymap.set("n", "<leader>wm", function()
      vscode.action("workbench.action.moveEditorToNextGroup")
    end)

    -- Open command pallete
    vim.keymap.set("n", "<leader>fc", function()
      vscode.action("workbench.action.showCommands")
    end)
end

-- Setup window movement and file searching
if not vim.g.vscode then
    window_movement_non_vscode()
else
    window_movement_vscode()
end

