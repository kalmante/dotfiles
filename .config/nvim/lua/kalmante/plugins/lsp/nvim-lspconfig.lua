local M = {}

M.spec = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    { 'b0o/schemastore.nvim', version = '*', lazy = true },
    {
      'folke/lazydev.nvim',
      event = 'VeryLazy',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { runtime = true },
          { plugins = true },
        },
      },
    },
  },
  config = function()
    -- Build capabilities from blink.cmp
    local cmp_cap = require('blink.cmp').get_lsp_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_cap or {})

    -- Diagnostics UI
    vim.diagnostic.config {
      float = { border = 'rounded' },
      virtual_text = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
      },
    }

    -- Common on_attach function
    local on_attach = function(client, bufnr)
      require('kalmante.util.lsp.keys').setup(bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    -- Lua LS
    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          hint = { enable = true },
          telemetry = { enable = false },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME .. '/lua' },
          },
        },
      },
    }

    vim.lsp.enable 'lua_ls'
  end,
}

return M.spec
