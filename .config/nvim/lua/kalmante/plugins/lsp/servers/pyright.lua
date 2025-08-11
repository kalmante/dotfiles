local util = require 'lspconfig.util'

---@class PyrightServerConfig
local M = {}

--- Setup the pyright LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'pyright' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'python' },
    root_dir = function(fname)
      return util.root_pattern(
        'pyproject.toml',
        'setup.py',
        'requirements.txt',
        '.git'
      )(fname) or vim.uv.cwd()
    end,

    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'strict', -- options: "off" | "basic" | "strict"
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
          autoImportCompletions = true,
          -- stubPath = 'typings',
        },
      },
    },
    single_file_support = true,
  }
end

M.name = 'pyright'

return M
