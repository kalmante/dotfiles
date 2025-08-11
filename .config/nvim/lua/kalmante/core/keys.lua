local M = {}

function M.general()
  local keys = vim.keymap
  keys.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })
  keys.set(
    'n',
    'x',
    '"_x',
    { desc = 'Delete char without copying to register' }
  )
  keys.set(
    'n',
    '<leader>+',
    '<C-a>',
    { desc = 'Increment number under cursor' }
  )
  keys.set(
    'n',
    '<leader>-',
    '<C-x>',
    { desc = 'Decrement number under cursor' }
  )
  keys.set('n', '<leader>n', '<cmd>enew<CR>', { desc = 'New file' })
end

function M.window()
  local keys = vim.keymap
  keys.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
  keys.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' })
  keys.set('n', '<leader>we', '<C-w>=', { desc = 'Equalize split sizes' })
  keys.set(
    'n',
    '<leader>wx',
    '<cmd>close<CR>',
    { desc = 'Close current split' }
  )
end

function M.tabs()
  local keys = vim.keymap
  keys.set('n', '<leader>/t', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
  keys.set(
    'n',
    '<leader>/x',
    '<cmd>tabclose<CR>',
    { desc = 'Close current tab' }
  )
  keys.set('n', '<leader>/n', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
  keys.set('n', '<leader>/p', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })
  keys.set(
    'n',
    '<leader>/b',
    '<cmd>tabnew %<CR>',
    { desc = 'Open current buffer in new tab' }
  )
end

function M.plugins()
  local keys = vim.keymap
  keys.set(
    'n',
    '<leader>l',
    '<cmd>Lazy<CR>',
    { desc = 'Open lazy.nvim plugin manager' }
  )
  keys.set(
    'n',
    '<leader>m',
    '<cmd>Mason<CR>',
    { desc = 'Open Mason tool manager' }
  )
  keys.set(
    'n',
    '<leader>ch',
    ':nohl<CR>',
    { desc = 'Clear highlights' }
  )
end

function M.inspect()
  local keys = vim.keymap
  keys.set(
    'n',
    '<leader>i',
    vim.show_pos,
    { desc = 'Inspect highlight groups under cursor' }
  )
  keys.set('n', '<leader>o', function()
    vim.treesitter.inspect_tree()
    vim.api.nvim_input 'I'
  end, { desc = 'Open Treesitter Inspector + Insert Mode' })
end

function M.comments()
  local keys = vim.keymap
  keys.set(
    'n',
    '<leader>cb',
    'o<esc>Vcx<esc><cmd>normal gcc<CR>fxa<BS>',
    { desc = 'Insert line below with comment' }
  )
  keys.set(
    'n',
    '<leader>ca',
    'O<esc>Vcx<esc><cmd>normal gcc<CR>fxa<BS>',
    { desc = 'Insert line above with comment' }
  )
  keys.set('n', '<leader>cc', function()
    local commentstring = vim.bo.commentstring:match '^(.*)%%s'
    local line = vim.api.nvim_get_current_line()
    if line:match('^%s*' .. vim.pesc(commentstring)) then
      line = line:gsub('^(%s*)' .. vim.pesc(commentstring) .. '%s*', '%1')
    else
      line = commentstring .. ' ' .. line
    end
    vim.api.nvim_set_current_line(line)
  end, { desc = 'Toggle line comment (manual implementation)' })
end

function M.quit()
  local keys = vim.keymap
  keys.set(
    'n',
    '<leader>q',
    '<cmd>qa<CR>',
    { desc = 'Quit all windows and exit' }
  )
end

function M.setup()
  M.general()
  M.window()
  M.tabs()
  M.plugins()
  M.comments()
  M.inspect()
  M.quit()
end

return M
