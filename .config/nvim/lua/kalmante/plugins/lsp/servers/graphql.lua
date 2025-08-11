local util = require 'lspconfig.util'

---@class GraphqlServerConfig
local M = {}

---@type string[]
local ts_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

--- Setup the graphql LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'graphql' } > 0 then
    return
  end

  local graphql_filetypes = vim.tbl_extend('force', ts_filetypes, { 'graphql' })

  local graphql_root_files = {
    '.graphqlrc',
    '.graphqlrc.json',
    '.graphqlrc.yaml',
    '.graphqlrc.yml',
    '.graphqlrc.js',
    '.graphqlrc.ts',
    'graphql.config.json',
    'graphql.config.js',
    'graphql.config.ts',
    'package.json',
    '.git',
  }

  server.setup {
    capabilities = capabilities,
    filetypes = graphql_filetypes,
    root_dir = util.root_pattern(unpack(graphql_root_files)),
    settings = {
      graphql = {
        -- Customize schema/projects here if needed
      },
    },
    single_file_support = true,
  }
end

M.name = 'graphql'

return M
