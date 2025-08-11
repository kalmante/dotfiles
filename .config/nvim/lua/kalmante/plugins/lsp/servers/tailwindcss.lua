local util = require 'lspconfig.util'

---@class TailwindCssServerConfig
local M = {}

local filetypes = {
  'html',
  'css',
  'scss',
  'sass',
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'vue',
  'svelte',
}

local function has_tailwind(root)
  local function exists(path)
    return vim.uv.fs_stat(path) ~= nil
  end

  if exists(vim.fs.joinpath(root, 'tailwind.config.js')) or
      exists(vim.fs.joinpath(root, 'tailwind.config.ts'))
  then
    return true
  end

  local pkg = vim.fs.joinpath(root, 'package.json')
  if exists(pkg) then
    local ok, content = pcall(vim.fn.readfile, pkg)
    if ok then
      local decoded = vim.fn.json_decode(table.concat(content, '\n'))
      if decoded then
        local deps = vim.tbl_extend('force', decoded.dependencies or {}, decoded.devDependencies or {})
        return deps['tailwindcss'] ~= nil
      end
    end
  end

  return false
end

--- Setup the tailwindcss LSP server with given capabilities.
--- @param server table The LSP server instance from lspconfig
--- @param capabilities table The capabilities object passed to the LSP server
function M.setup(server, capabilities)
  if #vim.lsp.get_clients { name = 'tailwindcss' } > 0 then
    return
  end

  server.setup {
    capabilities = capabilities,
    filetypes = filetypes,
    root_dir = function(fname)
      local root = util.root_pattern('tailwind.config.js', 'tailwind.config.ts')(fname)

      if root and has_tailwind(root) then
        return root
      end

      local pkg_root = util.root_pattern('package.json', '.git')(fname)
      if pkg_root and has_tailwind(pkg_root) then
        return pkg_root
      end

      return nil
    end,
    settings = {
      tailwindCSS = {
        lint = {
          cssConflict = 'warning',
          invalidApply = 'error',
          invalidScreen = 'error',
          recommendedVariantOrder = 'error',
        },
        experimental = {
          classRegex = {
            'tw`([^`]*)',
            'tw="([^"]*)',
            'tw$begin:math:text$([^)]*)\\$end:math:text$',
            'className="([^"]*)"',
            'className={`([^`]*)`}',
          },
        },
      },
    },
    single_file_support = false,
  }
end

M.name = 'tailwindcss'

return M
