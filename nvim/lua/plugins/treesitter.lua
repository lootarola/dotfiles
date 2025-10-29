return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'master',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'json', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'html' },
        additional_vim_regex_highlighting = { 'go' },
      },
      indent = { enable = true, disable = {} },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
} 