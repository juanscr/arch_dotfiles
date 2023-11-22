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

-- Move between windows
vim.keymap.set("n", "<leader>w", "<C-w>")
