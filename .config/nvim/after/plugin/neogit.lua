function setup_neogit()
    local neogit = require('neogit')
    neogit.setup {}
    vim.keymap.set('n', '<leader>gg', neogit.open)
end

if not vim.g.vscode then
    setup_neogit()
end
