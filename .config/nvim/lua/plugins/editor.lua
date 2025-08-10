local M = {}

M.spec = {
  -- Disable flash
  {
    'folke/flash.nvim',
    enabled = false,
  },

  -- vim-matchup
  {
    'andymass/vim-matchup',
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_timeout = 200
      vim.g.matchup_matchparen_insert_timeout = 100
      vim.g.matchup_override_vimtex = 1
      vim.g.matchup_enable = 1
    end,
  },
}

return M.spec
