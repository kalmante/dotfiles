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
          'stylua',
          'prettier',
          'eslint_d',
          'black',
          'isort',
          'shfmt',
          'goimports',
          'golangci-lint',
          'pylint',
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
          'html',
          'cssls',
          'tailwindcss',
          'astro',
          'svelte',
          'vtsls',              
          'eslint',
          'jsonls',
          'yamlls',
          'emmet_language_server',
          'graphql',
          'lua_ls',
          'marksman',             
          'pyright',              
          'gopls',               
        },
        automatic_enable = {
          exclude = {
            'marksman',
            'emmet_language_server',
            'html',
            'lua_ls',
            'astro',
            'svelte',
            'vtsls',
            'cssls',
            'tailwindcss',
            'jsonls',
            'yamlls',
            'graphql',
            'gopls',
            'pyright',
            'eslint',
          },
        },
      }
    end,
  },
}

return M.spec
