local util = require 'lspconfig.util'

---@class LuaServerConfig
local M = {}

--- Setup the Lua LSP server with given capabilities.
--- @param server table LSP server instance from lspconfig
--- @param capabilities table Capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients({ name = 'lua_ls' }) > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    root_dir = util.root_pattern('.git', 'init.lua', '.stowrc', 'wezterm.lua')(
    ---@diagnostic disable-next-line: undefined-field
      vim.loop.fs_realpath(vim.fn.expand('%:p'))
    ) or vim.fn.getcwd(),
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          globals = { 'vim' },
        },
        hint = { enable = true },
        telemetry = { enable = false },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  }
end

return M
