-- Custom keymaps configuration
local M = {}

function M.setup()
  -- Go
  vim.keymap.set('n', '<leader>lgt', '<cmd>GoTestFunc<CR>', { desc = 'Test Func' })
  vim.keymap.set('n', '<leader>lgc', '<cmd>GoCoverage<CR>', { desc = 'Coverage' })

  -- Octo
  vim.keymap.set('n', '<leader>oa', '<cmd>Octo<CR>', { desc = 'Actions' })
  vim.keymap.set('n', '<leader>op', '<cmd>Octo pr list<CR>', { desc = 'Pull Requests' })
  vim.keymap.set('n', '<leader>oi', '<cmd>Octo issue list<CR>', { desc = 'Issues' })

  -- Oil
  vim.keymap.set('n', '<leader>to', '<cmd>Oil<CR>', { desc = 'Oil' })

  -- Hardtime
  vim.keymap.set('n', '<leader>tH', '<cmd>Hardtime toggle<CR>', { desc = 'Hardtime' })

  -- v0.12 LSP Inline Completion
  -- vim.keymap.set('i', '<C-CR>', function()
  --  if not vim.lsp.inline_completion.get() then
  --    return '<C-CR>'
  --  end
  --  end, {
  --  expr = true,
  --  replace_keycodes = true,
  --  desc = 'Get the current inline completion',
  --  })
end

return M
