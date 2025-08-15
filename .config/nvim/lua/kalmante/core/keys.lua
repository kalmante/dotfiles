local M = {}

function M.general()
  vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })
  vim.keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
  vim.keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })
  vim.keymap.set('n', '<leader>N', '<cmd>enew<CR>', { desc = 'New buffer' })
end

function M.plugins()
  vim.keymap.set(
    'n',
    '<leader>L',
    '<cmd>Lazy<CR>',
    { desc = 'Lazy.nvim manager' }
  )
  vim.keymap.set('n', '<leader>M', '<cmd>Mason<CR>', { desc = 'Mason manager' })
  vim.keymap.set('n', '<leader>ch', ':nohl<CR>', { desc = 'Clear highlights' })
end

function M.comments()
  vim.keymap.set('n', '<leader>cc', function()
    local cs = vim.bo.commentstring:match '^(.*)%%s'
    local line = vim.api.nvim_get_current_line()
    if line:match('^%s*' .. vim.pesc(cs)) then
      line = line:gsub('^(%s*)' .. vim.pesc(cs) .. '%s*', '%1')
    else
      line = cs .. ' ' .. line
    end
    vim.api.nvim_set_current_line(line)
  end, { desc = 'Toggle line comment' })
end

function M.inspect()
  vim.keymap.set(
    'n',
    '<leader>I',
    vim.show_pos,
    { desc = 'Inspect highlight groups' }
  )
  vim.keymap.set('n', '<leader>O', function()
    vim.treesitter.inspect_tree()
    vim.api.nvim_input 'I'
  end, { desc = 'Treesitter Inspector + Insert' })
end

function M.quit()
  vim.keymap.set('n', '<leader>Q', '<cmd>qa<CR>', { desc = 'Quit all' })
end

function M.setup()
  M.general()
  M.plugins()
  M.comments()
  M.inspect()
  M.quit()
end

return M
