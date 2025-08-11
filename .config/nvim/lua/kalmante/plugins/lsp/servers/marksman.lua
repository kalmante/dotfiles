local util = require 'lspconfig.util'

---@class MarksmanServerConfig
local M = {}

--- Setup the Marksman LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'marksman' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = { 'markdown', 'markdown.mdx' },
    root_dir = function(fname)
      -- Prefer project markers for docs/blogs
      return util.root_pattern('.git', '.marksman.toml', '.marksman.json')(
        fname
      ) or vim.fn.getcwd()
    end,

    settings = {
      marksman = {
        lint = {
          -- Enable diagnostics for broken links and heading hierarchy
          unused_link_definitions = true,
          heading_increments = true,
        },
        -- Optionally enable frontmatter parsing
        frontmatter = {
          enabled = true,
          languages = { 'yaml' },
        },
      },
    },
    single_file_support = true,
  }
end

M.name = 'marksman'

return M
