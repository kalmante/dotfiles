local M = {}

M.spec = {
  'ibhagwan/fzf-lua',
  enabled = true,
  lazy = true,
  cmd = { 'FzfLua' },
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },

opts = {
  file_icon_padding = '',
  keymap = {
    fzf = {
      ['CTRL-Q'] = 'select-all+accept',
    },
  },
  fzf_opts = {
    ['--wrap'] = true,
    ['--ansi'] = true,
  },
  fzf_colors = true,
  winopts = {
    preview = {
      wrap = true,
    },
    formatter = 'path.dirname_first',
    treesitter = {
      enabled = true,
    },
  },
},

  keys = {
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find files',
    },
    {
      '<leader>fl',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Live grep across files',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').commands()
      end,
      desc = 'Search Neovim commands',
    },
    {
      '<leader>fh',
      function()
        require('fzf-lua').highlights()
      end,
      desc = 'Search highlights groups',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Search defined keymaps',
    },
    {
      '<leader>fm',
      function()
        require('fzf-lua').marks()
      end,
      desc = 'Search marks in buffer',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').resume()
      end,
      desc = 'Resume last search session',
    },
  },
}

return M.spec
