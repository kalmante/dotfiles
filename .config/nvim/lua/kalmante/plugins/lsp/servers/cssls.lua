local util = require 'lspconfig.util'

---@class CsslsServerConfig
local M = {}

--- Setup the Cssls LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'cssls' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'css', 'scss', 'less' },
    root_dir = util.root_pattern('package.json', '.git'),
    settings = {
      css = {
        validate = true,
        lint = { unknownAtRules = 'warning' },
      },
      scss = {
        validate = true,
        lint = { unknownAtRules = 'warning' },
      },
      less = {
        validate = true,
        lint = { unknownAtRules = 'warning' },
      },
    },
    single_file_support = true,
  }
end

M.name = 'cssls'

return M
