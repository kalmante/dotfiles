local keymap = vim.keymap

vim.g.leader = ' '

-- Exit insert mode with jk
keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- Clear search highlights
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })
