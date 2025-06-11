return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, 
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  { 
    'folke/todo-comments.nvim', 
    event = 'VimEnter', 
    dependencies = { 'nvim-lua/plenary.nvim' }, 
    opts = { signs = false } 
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add {
        { '<leader>d', name = '[D]ocument', icon = '󰈙' },
        { '<leader>r', name = '[R]ename', icon = '󰑕' },
        { '<leader>s', name = '[S]earch', icon = '' },
        { '<leader>w', name = '[W]orkspace', icon = '󱄄' },
        { '<leader>t', name = '[T]oggle', icon = '󰨚' },
        { '<leader>h', name = 'Git [H]unk', icon = '' },
        { '<leader>g', name = '[G]o', icon = '' },
      }
      -- visual mode
      require('which-key').add({
        { '<leader>h', 'Git [H]unk', icon = '' },
      }, { mode = 'v' })
    end,
  },
} 