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

  -- Disable snacks.nvim indent, scroll and dashboard
  {
    'snacks.nvim',
    opts = {
      indent = { enabled = false },
      scroll = { enabled = false },
      dashboard = { enabled = false },
    },
  },
}

return M.spec
