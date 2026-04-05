require('octo').setup {
  enable_builtin = true,
  default_merge_method = 'rebase',
  default_delete_branch = true,
  ssh_aliases = { ['github.com-emu'] = 'github.com' },
  picker = 'snacks',
  use_local_fs = true,
}
