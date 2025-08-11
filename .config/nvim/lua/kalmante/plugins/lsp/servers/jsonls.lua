local util = require 'lspconfig.util'
local ok, schemastore = pcall(require, 'schemastore')

---@class JsonlsServerConfig
local M = {}

--- Setup the jsonls LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  capabilities = capabilities or vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  if #vim.lsp.get_clients { name = 'jsonls' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = {
      'json',
      'jsonc',
    },
    root_dir = util.root_pattern(
      '.git',
      'package.json',
      '.jsonlintrc',
      '.jsonrc',
      '.eslintrc',
      '.prettierrc',
      'tsconfig.json',
      'tsconfig.app.json'
    ),
    settings = {
      json = {
        validate = true,
        schemaStore = {
          enable = true,
        },
        schemas = ok and schemastore.json.schemas() or {},
      },
    },
    single_file_support = true,
  }
end

M.name = 'jsonls'

return M
