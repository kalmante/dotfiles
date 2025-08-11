local util = require 'lspconfig.util'

---@class SvelteServerConfig
local M = {}

--- Setup the svelte LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'svelte' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'svelte' },
    root_dir = util.root_pattern(
      'svelte.config.js',
      'svelte.config.ts',
      'package.json',
      '.git'
    ),
    settings = {
      svelte = {
        plugin = {
          typescript = {
            diagnostics = { enabled = false },
          },
          eslint = {
            enabled = false,
          },
        },
      },
    },
    single_file_support = false,
  }
end

M.name = 'svelte'

return M
