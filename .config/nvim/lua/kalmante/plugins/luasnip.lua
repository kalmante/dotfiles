local M = {}

M.spec = {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  build = 'make install_jsregexp',

  dependencies = {
    'rafamadriz/friendly-snippets',
  },

  opts = {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
  },

  config = function(_, opts)
    local luasnip = require 'luasnip'
    luasnip.config.set_config(opts)

    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}

return M.spec
