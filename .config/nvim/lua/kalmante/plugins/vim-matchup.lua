local M = {}

M.spec = {
  'andymass/vim-matchup',
  event = {
    'BufReadPost',
    'BufNewFile',
  },

  init = function()
    -- Strongly recommended for performance with Treesitter
    vim.g.matchup_matchparen_offscreen = { method = 'popup' } -- 'status', 'popup', or nil
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_timeout = 200
    vim.g.matchup_matchparen_insert_timeout = 100
    vim.g.matchup_override_vimtex = 1 -- disable vimtex matchparen override if used

    -- Core plugin settings
    vim.g.matchup_enable = 1
    vim.g.matchup_transmute_enabled = 1
    vim.g.matchup_delim_stopline = 1000
    vim.g.matchup_matchparen_enabled = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
  end,
}

return M.spec
