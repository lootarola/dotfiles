require('sidekick').setup {}
vim.keymap.set('n', '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })
vim.keymap.set({ 'n', 'v' }, '<c-.>', function()
  require('sidekick.cli').focus()
end, { desc = 'Sidekick Switch Focus' })
vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
  require('sidekick.cli').toggle { focus = true }
end, { desc = 'Sidekick Toggle CLI' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', function()
  require('sidekick.cli').prompt()
end, { desc = 'Sidekick Ask Prompt' })
vim.keymap.set('n', '<leader>ad', function()
  require('sidekick.cli').close()
end, { desc = 'Detach a CLI Session' })
vim.keymap.set({ 'x', 'n' }, '<leader>as', function()
  require('sidekick.cli').send { msg = '{this}' }
end, { desc = 'Send This' })
vim.keymap.set('n', '<leader>af', function()
  require('sidekick.cli').send { msg = '{file}' }
end, { desc = 'Send File' })
vim.keymap.set('x', '<leader>av', function()
  require('sidekick.cli').send { msg = '{selection}' }
end, { desc = 'Send Visual Selection' })
