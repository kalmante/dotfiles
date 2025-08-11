local M = {}

M.spec = {
  {
    'williamboman/mason.nvim',
    version = '*',
    event = 'VeryLazy',
    opts = {
      ui = {
        border = 'none',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'black',
          'eslint_d',
          'golangci-lint',
          'goimports',
          'isort',
          'prettier',
          'pylint',
          'shfmt',
          'stylua',
        },
        run_on_start = false,
      }
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = {
          'astro',
          'cssls',
          'emmet_language_server',
          'eslint',
          'gopls',
          'graphql',
          'html',
          'jsonls',
          'lua_ls',
          'marksman',
          'pyright',
          'svelte',
          'tailwindcss',
          'vtsls',
          'yamlls',
        },
        automatic_enable = {
          exclude = {
            'astro',
            'cssls',
            'emmet_language_server',
            'eslint',
            'gopls',
            'graphql',
            'html',
            'jsonls',
            'lua_ls',
            'marksman',
            'pyright',
            'svelte',
            'tailwindcss',
            'vtsls',
            'yamlls',
          },
        },
      }
    end,
  },
}

return M.spec
