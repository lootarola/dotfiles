-- Custom keymaps configuration
local M = {}

function M.setup()
  -- Go
  vim.keymap.set('n', '<leader>gt', '<cmd>GoTestFunc<CR>', { desc = '[G]o [T]est Function' })
  vim.keymap.set('n', '<leader>gc', '<cmd>GoCoverage<CR>', { desc = '[G]o [C]overage' })
  vim.keymap.set('n', '<leader>ga', '<cmd>GoAddTags<CR>', { desc = '[G]o [A]dd Tags' })
  vim.keymap.set('n', '<leader>gr', '<cmd>GoRemoveTags<CR>', { desc = '[G]o [R]emove Tags' })
  vim.keymap.set('n', '<leader>gs', '<cmd>GoFillStruct<CR>', { desc = '[G]o Fill [S]truct' })
  vim.keymap.set('n', '<leader>gi', '<cmd>GoImpl<CR>', { desc = '[G]o [I]mplement Interface' })
  vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<CR>', { desc = '[G]o [E]rror Handling' })

  -- Commits
  vim.keymap.set('n', '<leader>cc', function()
    require('telescope').extensions.conventional_commits.conventional_commits()
  end, { desc = '[C]onventionalCommit' })

  vim.keymap.set('n', '<leader>cm', function()
    require('telescope').extensions.gitmoji.gitmoji()
  end, { desc = 'Git[M]oji' })

  -- Terminal
  vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = '[T]oggle [T]erminal' })

  -- Swagger
  vim.keymap.set('n', '<leader>ts', '<cmd>SwaggerPreviewToggle<CR>', { desc = '[T]oggle [S]wagger' })

  -- Oil
  vim.keymap.set('n', '<leader>to', '<cmd>Oil<CR>', { desc = '[T]oggle [O]il' })

  -- Octo
  vim.keymap.set('n', '<leader>oa', '<cmd>Octo<CR>', { desc = '[O]cto [A]ctions' })
  vim.keymap.set('n', '<leader>op', '<cmd>Octo pr list<CR>', { desc = '[O]cto [P]ull Requests' })
  vim.keymap.set('n', '<leader>oi', '<cmd>Octo issue list<CR>', { desc = '[O]cto [I]ssues' })

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
