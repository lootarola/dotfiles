return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      enable_builtin = true,
      default_merge_method = 'rebase',
      default_delete_branch = true,
      ssh_aliases = { ['github.com-emu'] = 'github.com' }, -- Remember to add work alias for github
      picker = 'snacks',
      use_local_fs = true,
    }
  end,
}
