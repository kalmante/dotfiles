local util = require 'lspconfig.util'

---@class AstroServerConfig
local M = {}

--- Setup the Astro LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'astro' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'astro' },
    root_dir = util.root_pattern(
      'astro.config.mjs',
      'astro.config.ts',
      'package.json',
      '.git'
    ),
    settings = {
      astro = {
        diagnostics = { enabled = true },
        plugin = {
          typescript = { diagnostics = { enabled = true } },
          eslint = { enabled = false },
        },
      },
    },
    single_file_support = false,
  }
end

M.name = 'astro'

return M
