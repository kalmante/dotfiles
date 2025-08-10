local M = {}

M.spec = {
  -- Disable tokyonight
  {
    'folke/tokyonight.nvim',
    enabled = false,
  },

  -- Disable catppuccin
  {
    'catppuccin/nvim',
    enabled = false,
  },

  -- solarized-osaka
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    event = 'UIEnter',

    opts = {
      use_background = 'dark',
      dim_inactive = true,
      border = 'rounded',
      enable_italics = true,
      lualine_bold = true,
      -- Theme variant: 'night' | 'storm' | 'moon' | 'day'
      style = 'moon',
      -- Only applies if style = 'day':
      -- 0.1 = very muted, 0.3 = slightly more vibrant
      day_brightness = 0.1,
      transparent = true,
      terminal_colors = true,
      styles = {
        boolean = { bold = true },
        comments = { italic = true },
        conditionals = { italic = true },
        functions = { bold = true },
        keywords = { bold = true, italic = false },
        loops = { italic = true },
        misc = { italic = true },
        numbers = { bold = true },
        operators = { bold = true },
        properties = { italic = true },
        string = { bold = true },
        types = { bold = true },
        variables = { bold = false },
        underline = true,
        undercurl = true,
      },
    },

    config = function(_, opts)
      require('solarized-osaka').setup(opts)
      vim.cmd.colorscheme 'solarized-osaka'

      vim.schedule(function()
        vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
      end)
    end,
  },
}

return M.spec
