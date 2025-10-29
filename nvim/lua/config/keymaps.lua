-- Custom keymaps configuration
local M = {}

function M.setup()
  -- Go
  vim.keymap.set('n', '<leader>lgt', '<cmd>GoTestFunc<CR>', { desc = '[T]est [G]o Func' })
  vim.keymap.set('n', '<leader>lgc', '<cmd>GoCoverage<CR>', { desc = '[T]est [C]overage [G]o' })

  -- Octo
  vim.keymap.set('n', '<leader>oa', '<cmd>Octo<CR>', { desc = '[O]cto [A]ctions' })
  vim.keymap.set('n', '<leader>op', '<cmd>Octo pr list<CR>', { desc = '[O]cto [P]ull Requests' })
  vim.keymap.set('n', '<leader>oi', '<cmd>Octo issue list<CR>', { desc = '[O]cto [I]ssues' })

  -- Oil
  vim.keymap.set('n', '<leader>to', '<cmd>Oil<CR>', { desc = '[O]il' })

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
