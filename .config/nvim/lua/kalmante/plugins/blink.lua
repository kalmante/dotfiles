local M = {}

M.spec = {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter' },
  dependencies = {
    {
      'saghen/blink.compat',
      optional = true,
      version = '1.*',
    },
  },

  opts = function()
    local luasnip = require 'luasnip'

    local opts = {
      snippets = {
        preset = 'luasnip',
        expand = function(body)
          luasnip.lsp_expand(body)
        end,
      },

      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      signature = {
        enabled = true,
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },

      completion = {
        ghost_text = {
          enabled = true,
        },
        trigger = {
          show_on_keyword = true,
        },
        menu = {
          draw = {
            treesitter = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
          },
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
        },
        documentation = {
          window = {
            border = 'rounded',
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
          },
        },
      },

      cmdline = {
        keymap = {
          preset = 'inherit',
        },
        completion = {
          ghost_text = {
            enabled = false,
          },
          menu = {
            auto_show = false,
          },
        },
      },
    }

    return opts
  end,
}

return M.spec
