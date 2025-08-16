---@class EmmetServerConfig
local M = {}

--- Setup the emmet_language_server LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'emmet_language_server' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = {
      'html',
      'css',
      'scss',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'astro',
    },
    init_options = {
      includeLanguages = {
        javascript = 'javascriptreact',
        typescript = 'typescriptreact',
      },
      showExpandedAbbreviation = 'always',
      showAbbreviationSuggestions = true,
      options = {
        ['bem.enabled'] = true,
        ['output.selfClosingTag'] = true,
      },
    },
    single_file_support = true,
  }
end

M.name = 'emmet_language_server'

return M
