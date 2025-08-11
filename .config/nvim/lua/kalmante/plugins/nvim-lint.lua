local M = {}

M.spec = {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*',

  opts = {
    linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    },
  },

  config = function(_, opts)
    local lint = require 'lint'
    lint.linters_by_ft = opts.linters_by_ft

    -- Run lint only if ESLint LSP is NOT attached
    local function lint_if_no_eslint()
      local ft = vim.bo.filetype

      -- Check if eslint LSP client is active
      local eslint_attached = #vim.lsp.get_clients {
        name = 'eslint',
        bufnr = 0,
      } > 0
      if not eslint_attached and lint.linters_by_ft[ft] then
        lint.try_lint()
      end
    end

    -- Auto lint on key events
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
      group = vim.api.nvim_create_augroup(
        'nvim-lint-autogroup',
        { clear = true }
      ),
      callback = lint_if_no_eslint,
    })

    -- Manual lint keymap
    vim.keymap.set('n', '<leader>lL', function()
      lint_if_no_eslint()
    end, { desc = 'Run linter manually (eslint_d fallback)' })

    vim.keymap.set('n', '<leader>le', function()
      vim.diagnostic.setqflist()
    end, { desc = 'Linter Errors to Quickfix' })
  end,
}

return M.spec
