local root_pattern = require('lspconfig.util').root_pattern

---@class GoplsServerConfig
local M = {}

--- Setup the gopls LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'gopls' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = {
      'go',
      'gomod',
      'gowork',
    },
    root_dir = function(fname)
      return root_pattern('go.work', 'go.mod', '.git')(fname) or vim.fn.getcwd()
    end,
    settings = {
      gopls = {
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        semanticTokens = true,
        matcher = 'Fuzzy', -- "Fuzzy" | "CaseSensitive" | "CaseInsensitive"
        directoryFilters = { '-.git', '-node_modules', '-vendor' },
        analyses = {
          unusedparams = true,
          unreachable = true,
          fieldalignment = true,
          nilness = true,
          unusedwrite = true,
          shadow = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
    single_file_support = true,
  }
end

M.name = 'gopls'

return M
