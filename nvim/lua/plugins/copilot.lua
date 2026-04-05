require('copilot').setup {
  panel = {
    enabled = true,
    keymap = {
      open = '<C-.>',
    },
  },
  suggestion = {
    enabled = false,
  },
  filetypes = {
    ['.'] = true,
  },
}
