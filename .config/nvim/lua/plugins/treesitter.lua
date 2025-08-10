local M = {}

M.spec = {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  event = { 'LazyFile', 'VeryLazy' },

  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      'astro',
      'bash',
      'css',
      'diff',
      'gitignore',
      'graphql',
      'html',
      'http',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'svelte',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
      'query',
      'regex',
    },
  },
}

return M.spec
