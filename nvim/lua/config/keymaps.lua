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
  vim.keymap.set('n', '<leader>mc', function()
    require('telescope').extensions.conventional_commits.conventional_commits()
  end, { desc = '[C]onventionalCommit' })

  vim.keymap.set('n', '<leader>mm', function()
    require('telescope').extensions.gitmoji.gitmoji()
  end, { desc = 'Git[M]oji' })

  -- Code Companion
  vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>', { desc = '[C]odeCompanion [C]hat' })
  vim.keymap.set({ 'n', 'v' }, '<leader>ci', '<cmd>CodeCompanion<CR>', { desc = '[C]odeCompanion [I]nline' })
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>CodeCompanionActions<CR>', { desc = '[C]odeCompanion [A]ctions' })
  vim.keymap.set('v', '<leader>cc', '<cmd>CodeCompanionChat Add<CR>', { desc = '[C]odeCompanion [C]opy' })

  -- Terminal
  vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = '[T]oggle [T]erminal' })

  -- Swagger
  vim.keymap.set('n', '<leader>ts', '<cmd>SwaggerPreviewToggle<CR>', { desc = '[T]oggle [S]wagger' })

  -- Oil
  vim.keymap.set('n', '<leader>o', '<cmd>Oil<CR>', { desc = '[O]il' })
end

return M
