-- Exit insert mode with jk
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- Clear search highlights
vim.keymap.set(
  'n',
  '<leader>nh',
  ':nohl<CR>',
  { desc = 'Clear search highlights' }
)
