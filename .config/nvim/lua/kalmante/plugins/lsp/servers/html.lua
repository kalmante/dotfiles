local util = require 'lspconfig.util'

---@class HtmlServerConfig
local M = {}

--- Setup the HTML LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'html' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'html' },
    root_dir = util.root_pattern('index.html', 'package.json', '.git'),
    single_file_support = true,

    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
    end,

    settings = {
      html = {
        format = {
          wrapLineLength = 80,
          unformatted = 'pre,code,textarea',
        },
        hover = {
          documentation = true,
          references = true,
        },
        suggest = {
          html5 = true,
        },
        validate = {
          scripts = true,
          styles = true,
        },
      },
    },
  }
end

M.name = 'html'

return M
