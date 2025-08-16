local util = require 'lspconfig.util'
local ok, schemastore = pcall(require, 'schemastore')

---@class YamllsServerConfig
local M = {}

--- Setup the yamlls LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'yamlls' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'yaml', 'yml' },
    root_dir = util.root_pattern('.git', '.github'),

    settings = {
      yaml = {
        validate = true,
        format = { enable = false },
        keyOrdering = false,
        -- enable schema store for automatic schema fetching
        schemaStore = { enable = true },
        schemas = ok and schemastore.yaml.schemas() or {
          {
            description = 'GitHub Actions workflow',
            fileMatch = { '.github/workflows/*' },
            url = 'https://json.schemastore.org/github-workflow.json',
          },
          {
            description = 'YAML Lint configuration',
            fileMatch = { '.yamllint' },
            url = vim.fn.stdpath 'config' .. '/schemas/yamllint.json',
          },
        },
      },
    },
    single_file_support = true,
  }
end

M.name = 'yamlls'

return M
