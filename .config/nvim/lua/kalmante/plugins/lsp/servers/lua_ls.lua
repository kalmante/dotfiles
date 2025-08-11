local M = {}

function M.setup(server, capabilities)
  if #vim.lsp.get_clients({ name = 'lua_ls' }) > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
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
