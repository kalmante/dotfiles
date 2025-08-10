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

  -- Disable snacks indent, scroll and dashboard
  {
    'snacks.nvim',
    opts = {
      indent = { enabled = false },
      scroll = { enabled = false },
      dashboard = { enabled = false },
    },
  },

  -- incline
  {
    'b0o/incline.nvim',
    event = 'BufReadPre',
    priority = 1200,
    dependencies = { 'craftzdog/solarized-osaka.nvim' },

    config = function()
      ---@type table<string, string> colors
      local colors = require('solarized-osaka.colors').setup()
      require('incline').setup {
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = {
              guifg = colors.violet500,
              guibg = colors.base03,
            },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },

        ---@class RenderProps
        ---@field buf number
        ---@param props RenderProps
        render = function(props)
          ---@type string
          local filename =
            vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if vim.bo[props.buf].modified then
            filename = '[+]' .. filename
          end

          ---@type string, string
          local icon, color =
            require('nvim-web-devicons').get_icon_color(filename)
          return { { icon, guifg = color }, { ' ' }, { filename } }
        end,
      }
    end,
  },
}

return M.spec
