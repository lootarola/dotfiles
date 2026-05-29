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

  -- Window / pane navigation (falls back to tmux at edges)
  local nav = require('config.nav')
  vim.keymap.set('n', '<C-h>', function() nav.navigate('h') end, { desc = 'Move focus left' })
  vim.keymap.set('n', '<C-j>', function() nav.navigate('j') end, { desc = 'Move focus down' })
  vim.keymap.set('n', '<C-k>', function() nav.navigate('k') end, { desc = 'Move focus up' })
  vim.keymap.set('n', '<C-l>', function() nav.navigate('l') end, { desc = 'Move focus right' })
  vim.keymap.set('t', '<C-h>', function() nav.navigate('h') end, { desc = 'Move focus left' })
  vim.keymap.set('t', '<C-j>', function() nav.navigate('j') end, { desc = 'Move focus down' })
  vim.keymap.set('t', '<C-k>', function() nav.navigate('k') end, { desc = 'Move focus up' })
  vim.keymap.set('t', '<C-l>', function() nav.navigate('l') end, { desc = 'Move focus right' })

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
