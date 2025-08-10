local M = {}

M.spec = {
  -- Mason tools
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'shfmt',
        'stylua',
        'prettier',
        'eslint_d',
        'css-lsp',
        'tailwindcss-language-server',
        'html-lsp',
        'astro-language-server',
        'svelte-language-server',
        'typescript-language-server',
        'emmet-language-server',
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {

        html = {
          settings = {
            html = {
              format = {
                wrapLineLength = 80,
                unformatted = 'pre,code,textarea',
              },
              hover = {
                documentation = true,
                reference = true,
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
        },

        cssls = {
          settings = {
            css = {
              validate = true,
              lint = { unknownAtRules = 'warning' },
            },
            scss = {
              validate = true,
              lint = { unknownAtRules = 'warning' },
            },
            less = {
              validate = true,
              lint = { unknownAtRules = 'warning' },
            },
          },
        },

        emmet_language_server = {
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
        },

        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = 'Both',
              },
              misc = {
                parameters = {},
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
              doc = {
                privateName = { '^_' },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { 'incomplete-signature-doc', 'trailing-space' },
                groupSeverity = {
                  strong = 'Warning',
                  strict = 'Warning',
                },
                groupFileStatus = {
                  ['ambiguity'] = 'Opened',
                  ['await'] = 'Opened',
                  ['codestyle'] = 'None',
                  ['duplicate'] = 'Opened',
                  ['global'] = 'Opened',
                  ['luadoc'] = 'Opened',
                  ['redefined'] = 'Opened',
                  ['strict'] = 'Opened',
                  ['strong'] = 'Opened',
                  ['type-check'] = 'Opened',
                  ['unbalanced'] = 'Opened',
                  ['unused'] = 'Opened',
                },
                unusedLocalExclude = { '_*' },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  continuation_indent_size = '2',
                },
              },
            },
          },
        },

        astro = {
          filetypes = { 'astro' },
          settings = {
            astro = {
              diagnostics = { enabled = true },
              plugins = {
                typescript = { enabled = true },
                eslint = { enabled = true },
              },
            },
          },
          single_file_support = true,
        },

        svelte = {
          filetypes = { 'svelte' },
          settings = {
            svelte = {
              diagnostics = { enabled = true },
              plugins = {
                typescript = { enabled = true },
                eslint = { enabled = true },
              },
            },
          },
          single_file_support = true,
        },

        jsonls = {},
      },
    },
  },
}

return M.spec
