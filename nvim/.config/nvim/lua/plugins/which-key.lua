require('which-key').setup()
require('which-key').add {
  { '<leader>a', name = 'AI', icon = '' },
  { '<leader>b', name = 'Buffer', icon = '' },
  { '<leader>f', name = 'File', icon = '' },
  { '<leader>g', name = 'Git', icon = '' },
  { '<leader>h', name = 'Hunk', icon = '' },
  { '<leader>l', name = 'Language', icon = '' },
  { '<leader>lg', name = 'Go', icon = '' },
  { '<leader>ll', name = 'LSP', icon = '' },
  { '<leader>o', name = 'Octo', icon = '' },
  { '<leader>r', name = 'Rename', icon = '󰑕' },
  { '<leader>s', name = 'Search', icon = '' },
  { '<leader>t', name = 'Toggle', icon = '󰨚' },
  { '<leader>w', name = 'Workspace', icon = '󱄄' },
}
require('which-key').add({
  { '<leader>h', 'Hunk', icon = '' },
}, { mode = 'v' })
