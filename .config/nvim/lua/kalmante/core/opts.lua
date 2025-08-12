local M = {}

function M.leader()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'
end

function M.ui()
  vim.opt.background = 'dark'
  vim.opt.cmdheight = 0
  vim.opt.cursorline = false
  vim.opt.laststatus = 0
  vim.opt.number = true
  vim.opt.numberwidth = 3
  vim.opt.relativenumber = true
  vim.opt.scrolloff = 8
  vim.opt.showcmd = false
  vim.opt.showmode = false
  vim.opt.signcolumn = 'yes:1'
  vim.opt.statuscolumn = '%l%s'
  vim.opt.termguicolors = true
  vim.opt.title = true
  vim.opt.wrap = false
  vim.opt.conceallevel = 2
  vim.opt.fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
  }
end

function M.splits()
  vim.opt.splitbelow = true
  vim.opt.splitkeep = 'cursor'
  vim.opt.splitright = true
end

function M.indent()
  vim.opt.autoindent = true
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.smartindent = true
  vim.opt.tabstop = 2
end

function M.search()
  vim.opt.hlsearch = true
  vim.opt.ignorecase = true
  vim.opt.inccommand = 'split'
  vim.opt.smartcase = true
end

function M.behavior()
  vim.opt.mouse = ''
  vim.opt.list = false
  vim.opt.spelllang = { 'en' }
  vim.opt.timeoutlen = vim.g.vscode and 1000 or 300
end

function M.shell()
  vim.opt.shell = 'zsh'
  vim.opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
  vim.opt.completeopt = 'menu,menuone,noselect'
end

function M.misc()
  vim.opt.formatoptions:append { 'r' }
  vim.opt.path:append { '**' }
  vim.opt.shortmess:append { W = true, I = true, c = true, C = true }
  vim.opt.wildignore:append { '*/node_modules/*' }
  vim.opt.wildmode = 'longest:full,full'
  vim.opt.backspace = { 'start', 'eol', 'indent' }
  vim.opt.backup = false
  vim.opt.swapfile = false
  vim.g.deprecation_warnings = true

  -- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/config/options.lua
  vim.cmd [[let &t_Cs = "\e[4:3m"]]
  vim.cmd [[let &t_Ce = "\e[4:0m"]]
  vim.cmd [[set t_ZH=[3m]]
  vim.cmd [[set t_ZR=[23m]]
end

function M.setup()
  M.leader()
  M.ui()
  M.splits()
  M.indent()
  M.search()
  M.behavior()
  M.shell()
  M.misc()
end

return M
