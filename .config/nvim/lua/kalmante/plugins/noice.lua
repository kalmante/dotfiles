local M = {}

M.spec = {
  'folke/noice.nvim',
  event = { 'CmdlineEnter', 'LspAttach' },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      event = 'VeryLazy',
      config = function()
        vim.notify = require 'notify'
      end,
    },
  },

  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    hover = {
      enabled = true,
      silent = true,
    },
  },

  keys = {
    { '<leader>n', '', desc = '+noice' },

    {
      '<S-Enter>',
      mode = 'c',
      desc = 'Redirect Cmdline',
      callback = function()
        require('noice').redirect(vim.fn.getcmdline())
      end,
    },

    {
      '<leader>nl',
      desc = 'Noice Last Message',
      callback = function()
        require('noice').cmd 'last'
      end,
    },

    {
      '<leader>nh',
      desc = 'Noice History',
      callback = function()
        require('noice').cmd 'history'
      end,
    },

    {
      '<leader>na',
      desc = 'Noice All',
      callback = function()
        require('noice').cmd 'all'
      end,
    },

    {
      '<leader>nd',
      desc = 'Dismiss All',
      callback = function()
        require('noice').cmd 'dismiss'
      end,
    },

    {
      '<leader>np',
      desc = 'Noice Picker (FzfLua)',
      callback = function()
        require('noice').cmd 'pick'
      end,
    },
  },

  config = function(_, opts)
    require('noice').setup(opts)
  end,
}

return M.spec
