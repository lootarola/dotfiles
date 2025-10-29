return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      enable_builtin = true,
      default_merge_method = 'rebase',
      default_delete_branch = true,
      ssh_aliases = { ['github.com-work'] = 'github.com' }, -- Remember to add work alias for github
      picker = 'telescope',
      use_local_fs = true,
    }
  end,
}
