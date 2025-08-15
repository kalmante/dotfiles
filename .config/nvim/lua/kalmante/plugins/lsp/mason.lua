local M = {}

M.spec = {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
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
    event = 'VeryLazy',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
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
    },
  },

  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
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
    },
  },
}

return M.spec
