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

  -- Disable snacks indent scroll
  {
    'snacks.nvim',
    opts = {
      indent = { enabled = false },
      scroll = { enabled = false },
    },
  },
}

return M.spec
