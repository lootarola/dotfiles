local M = {}

function M.setup()
  -- Clear search highlight
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Unset default autocompletion in nvim
  vim.keymap.set('i', '<C-p>', '<Nop>', { silent = true })
  vim.keymap.set('i', '<C-y>', '<Nop>', { silent = true })
  vim.keymap.set('i', '<C-n>', '<Nop>', { silent = true })

  -- Diagnostic
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1 }
  end, { desc = 'Go to previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1 }
  end, { desc = 'Go to next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Window navigation
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

  -- LSP Inline Completion
  vim.keymap.set('i', '<Tab>', function()
    if not vim.lsp.inline_completion.get() then
      return '<Tab>'
    end
  end, { expr = true, replace_keycodes = true, desc = 'Accept inline completion or fallback to Tab' })
end

return M
