local M = {}

M.spec = {
  'stevearc/conform.nvim',
  version = 'v9.0.0',
  event = { 'BufReadPre', 'BufNewFile' },

  opts = {
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 1000,
    },
    format_after_save = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      ['*'] = { 'codespell' },
      ['_'] = { 'trim_whitespace' },
      astro = { 'prettier' },
      css = { 'prettier' },
      go = { 'goimports', 'gofmt' },
      graphql = { 'prettier' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      python = { 'isort', 'black' },
      sh = { 'shfmt' },
      svelte = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      yaml = { 'prettier' },
    },

    formatters = {
      eslint_d = {
        condition = function(ctx)
          return vim.fs.find({
            '.eslintrc',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.json',
            'eslint.config.js',
            'eslint.config.cjs',
            'eslint.config.mjs',
            'eslint.config.ts',
            'package.json',
          }, { upward = true, path = ctx.filename })[1] ~= nil
        end,
      },
    },

    -- Set log level to avoid noisy output but still capture formatter errors
    log_level = vim.log.levels.ERROR,
    notify_no_formatters = true,
    notify_on_error = true,
  },

  config = function(_, opts)
    local conform = require 'conform'
    conform.setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format { async = false, lsp_format = 'fallback' }
    end, { desc = 'Format file or range (Conform)' })
  end,
}

return M.spec
