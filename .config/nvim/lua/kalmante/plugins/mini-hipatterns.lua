local M = {}

M.spec = {
  'echasnovski/mini.hipatterns',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },

  opts = function()
    local hipatterns = require 'mini.hipatterns'

    local highlighters = {
      fixme = {
        pattern = '%f[%w]()FIXME()%f[%W]',
        group = 'MiniHipatternsFixme',
      },
      hack = {
        pattern = '%f[%w]()HACK()%f[%W]',
        group = 'MiniHipatternsHack',
      },
      todo = {
        pattern = '%f[%w]()TODO()%f[%W]',
        group = 'MiniHipatternsTodo',
      },
      note = {
        pattern = '%f[%w]()NOTE()%f[%W]',
        group = 'MiniHipatternsNote',
      },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    }

    return {
      highlighters = highlighters,
      delay = { text_change = 200, scroll = 50 },
    }
  end,

  config = function(_, opts)
    require('mini.hipatterns').setup(opts)
  end,
}

return M.spec
