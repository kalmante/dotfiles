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
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      lazy = true,
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
    },
  },

  opts = function()
    local opts = {
      snippets = {
        preset = 'luasnip',
        expand = function(body)
          local ok, luasnip = pcall(require, 'luasnip')
          if not ok then
            require('lazy').load { plugins = { 'LuaSnip' } }
            luasnip = require 'luasnip'
          end
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
            treesitter = { enabled = true },
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
    }
    return opts
  end,
}

return M.spec
