local M = {}

function M.setup(bufnr)
  local map = vim.keymap.set
  local opts = { buffer = bufnr, silent = true }

  -- FZF-Lua LSP navigation
  local fzf = require 'fzf-lua'

  map(
    'n',
    '<leader>lr',
    fzf.lsp_references,
    { desc = 'LSP: References', unpack(opts) }
  )
  map(
    'n',
    '<leader>ld',
    fzf.lsp_definitions,
    { desc = 'LSP: Definitions', unpack(opts) }
  )
  map(
    'n',
    '<leader>li',
    fzf.lsp_implementations,
    { desc = 'LSP: Implementations', unpack(opts) }
  )
  map(
    'n',
    '<leader>lt',
    fzf.lsp_typedefs,
    { desc = 'LSP: Type Definitions', unpack(opts) }
  )
  map(
    'n',
    '<leader>lx',
    fzf.lsp_document_diagnostics,
    { desc = 'LSP: Diagnostics', unpack(opts) }
  )

  -- LSP Core Features
  map('n', '<leader>lh', function()
    vim.lsp.buf.hover { border = 'rounded' }
  end, { desc = 'LSP: Hover', unpack(opts) })

  map(
    { 'n', 'v' },
    '<leader>lc',
    vim.lsp.buf.code_action,
    { desc = 'LSP: Code Action', unpack(opts) }
  )
  map(
    'n',
    '<leader>ln',
    vim.lsp.buf.rename,
    { desc = 'LSP: Rename Symbol', unpack(opts) }
  )

  -- Diagnostics
  map('n', '<leader>ll', function()
    vim.diagnostic.open_float(nil, { border = 'rounded', focusable = true })
  end, { desc = 'Diagnostics: Line Float', unpack(opts) })

  map('n', '<leader>xw', function()
    vim.diagnostic.setloclist()
  end, { desc = 'LSP: Location List' })

  map('n', '[d', function()
    vim.diagnostic.jump { count = -1, float = true }
  end, { desc = 'Diagnostics: Prev', unpack(opts) })

  map('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
  end, { desc = 'Diagnostics: Next', unpack(opts) })

  -- Restart all clients
  map('n', '<leader>ls', function()
    for _, c in pairs(vim.lsp.get_clients { bufnr = bufnr }) do
      c:stop()
    end
    vim.defer_fn(function()
      vim.cmd.edit()
    end, 100)
  end, { desc = 'LSP: Restart all clients (Safe)', unpack(opts) })
end

return M
