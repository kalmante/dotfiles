local util = require 'lspconfig.util'

---@class VtslsServerConfig
local M = {}

--- Setup the vtsls LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'vtsls' } > 0 then
    return
  end

  --- Inlay hints configuration for JavaScript and TypeScript
  local ts_inlay_hints = {
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
  }

  server.setup {
    capabilities = capabilities,
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      -- allows TS support inside Astro for React integration
      'astro',
    },
    root_dir = function(fname)
      -- Detect TS/JS project root via config files
      return util.root_pattern(
            'tsconfig.json',
            'tsconfig.base.json',
            'tsconfig.app.json',
            'tsconfig.node.json',
            'jsconfig.json',
            'package.json'
          )(fname) or
          -- Fall back to package manager lockfiles or .git
          util.root_pattern(
            'package-lock.json',
            'pnpm-lock.yaml',
            'pnpm-workspace.yaml',
            'yarn.lock',
            'bun.lock',
            'bun.lockb',
            '.git'
          )(fname)
    end,
    settings = {
      typescript = {
        inlayHints = ts_inlay_hints,
        updateImportsOnFileMove = { enabled = 'always' },
        completions = { completeFunctionCalls = true },
      },
      javascript = {
        inlayHints = ts_inlay_hints,
        completions = { completeFunctionCalls = true },
      },
      vtsls = {
        -- vtsls handles workspace SDK resolution
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
            preferredPackageManager = 'npm',
          },
        },
      },
    },
    single_file_support = false,
  }
end

M.name = 'vtsls'

return M
