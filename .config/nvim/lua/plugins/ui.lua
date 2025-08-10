local M = {}

M.spec = {
  -- Disable bufferline
  {
    'akinsho/bufferline.nvim',
    enabled = false,
  },

  -- Disable lualine
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
  },
}

return M.spec
