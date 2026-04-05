local gh = function(x)
  return 'https://github.com/' .. x
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add {
  -- Libraries
  gh 'MunifTanjim/nui.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'rcarriga/nvim-notify',

  -- Colorscheme
  gh 'folke/tokyonight.nvim',

  -- Core UI
  gh 'folke/snacks.nvim',
  gh 'folke/which-key.nvim',
  gh 'folke/noice.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'folke/sidekick.nvim',
  gh 'MeanderingProgrammer/render-markdown.nvim',

  -- Completion + AI
  { src = gh 'saghen/blink.cmp', version = 'v1.0.0' },
  gh 'zbirenbaum/copilot.lua',

  -- Treesitter
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },

  -- LSP ecosystem
  gh 'williamboman/mason.nvim',
  gh 'williamboman/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'j-hui/fidget.nvim',
  gh 'folke/lazydev.nvim',
  gh 'stevearc/conform.nvim',
  gh 'jmbuhr/otter.nvim',
  gh 'mfussenegger/nvim-lint',

  -- Git
  gh 'lewis6991/gitsigns.nvim',
  gh 'sindrets/diffview.nvim',

  -- File management
  gh 'stevearc/oil.nvim',

  -- Language specific
  gh 'fatih/vim-go',

  -- Editing
  gh 'tpope/vim-sleuth',
  gh 'windwp/nvim-autopairs',
  gh 'echasnovski/mini.nvim',
  gh 'echasnovski/mini.diff',
  gh 'm4xshen/hardtime.nvim',

  -- GitHub
  gh 'pwntester/octo.nvim',
}

vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.hi 'Comment gui=none'

require 'plugins.snacks'
require 'plugins.cmp'
require 'plugins.copilot'
require 'plugins.treesitter'
require 'plugins.lsp'
require 'plugins.todo-comments'
require 'plugins.sidekick'
require 'plugins.noice'
require 'plugins.render-markdown'
require 'plugins.which-key'
require 'plugins.git'
require 'plugins.mini'
require 'plugins.core'
require 'plugins.oil'
require 'plugins.hardtime'
require 'plugins.octo'
require('config.keymaps').setup()
