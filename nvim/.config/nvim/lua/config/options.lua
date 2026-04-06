-- Leader keys (must be set before plugins load)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- UI
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'

-- Editing
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.scrolloff = 10

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Copilot
vim.lsp.enable 'copilot'
vim.lsp.inline_completion.enable()
