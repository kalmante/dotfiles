local M = {}

M.spec = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },

  dependencies = {
    'saghen/blink.cmp',
    {
      'b0o/schemastore.nvim',
      version = '*',
      lazy = true,
    },
    {
      'folke/lazydev.nvim',
      event = 'VeryLazy',
      ft = 'lua',
      opts = {
        library = {
          {
            path =
            '${3rd}/luv/library',
            words = { 'vim%.uv'
            }
          },
          { runtime = true },
          { plugins = true },
        },
      },
    },
  },

  config = function()
    local lspconfig = require 'lspconfig'
    require 'lspconfig.configs'

    local capabilities = vim.g.lsp_capabilities
        or require(
          'blink-cmp'
        ).get_lsp_capabilities()
    vim.g.lsp_capabilities = capabilities

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

    -- Inlay hints & keys
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client then
          require('kalmante.util.lsp.keys').setup(event.buf)

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end
        end
      end,
    })

    -- Local servers
    local servers = {
      'html',
      'astro',
      'svelte',
      'vtsls',
      'cssls',
      'tailwindcss',
      'jsonls',
      'marksman',
      'emmet_language_server',
      'yamlls',
      'graphql',
      'gopls',
      'pyright',
    }

    for _, server in ipairs(servers) do
      if lspconfig[server] then
        local ok, module =
            pcall(require, 'kalmante.plugins.lsp.servers.' .. server)
        if ok and type(module.setup) == 'function' then
          module.setup(lspconfig[server], capabilities)
        end
      else
        vim.notify(
          'LSP server config not found: ' .. server,
          vim.log.levels.WARN
        )
      end
    end

    -- Setup lua_ls separately
    if lspconfig.lua_ls then
      require(
        'kalmante.plugins.lsp.servers.lua_ls'
      ).setup(
        lspconfig.lua_ls,
        capabilities
      )
    else
      vim.notify(
        'LSP server config not found: lua_ls',
        vim.log.levels.WARN)
    end
  end,
}

return M.spec
