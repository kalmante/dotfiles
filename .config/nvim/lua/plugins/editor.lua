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

  -- vim-tmux-navigator
  {
    'christoomey/vim-tmux-navigator',

    keys = {
      { '<C-h>', desc = 'Navigate to left tmux pane' },
      { '<C-j>', desc = 'Navigate to down tmux pane' },
      { '<C-k>', desc = 'Navigate to up tmux pane' },
      { '<C-l>', desc = 'Navigate to right tmux pane' },
    },

    config = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
}

return M.spec
