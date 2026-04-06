---@type snacks.Config
require('snacks').setup {
  image = { enabled = false },
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
}

-- Debug globals
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end

if vim.fn.has 'nvim-0.11' == 1 then
  vim._print = function(_, ...)
    dd(...)
  end
else
  vim.print = _G.dd
end

-- Toggle mappings
Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tN'
Snacks.toggle.diagnostics():map '<leader>td'
Snacks.toggle.line_number():map '<leader>tl'
Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
Snacks.toggle.treesitter():map '<leader>tT'
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>tb'
Snacks.toggle.inlay_hints():map '<leader>th'
Snacks.toggle.indent():map '<leader>tg'
Snacks.toggle.dim():map '<leader>tD'

-- Search / Find
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'Smart Find Files' })
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.search_history() end, { desc = 'Search History' })
vim.keymap.set('n', '<leader>sn', function() Snacks.picker.notifications() end, { desc = 'Notification History' })
vim.keymap.set('n', '<leader>se', function() Snacks.explorer() end, { desc = 'File Explorer' })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find Config File' })
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>g', function() Snacks.picker.git_files() end, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' .. '/lua/plugins' } end, { desc = 'Search Plugin Files' })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.recent() end, { desc = 'Recent' })
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
vim.keymap.set('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })
vim.keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.help() end, { desc = 'Help Pages' })
vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
vim.keymap.set('n', '<leader>tC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })

-- Git
vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
vim.keymap.set('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' })
vim.keymap.set({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })

-- LSP navigation
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = 'References' })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
vim.keymap.set('n', 'gai', function() Snacks.picker.lsp_incoming_calls() end, { desc = 'C[a]lls Incoming' })
vim.keymap.set('n', 'gao', function() Snacks.picker.lsp_outgoing_calls() end, { desc = 'C[a]lls Outgoing' })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

-- Utilities
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })
vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
vim.keymap.set('n', '<leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification History' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete' })
vim.keymap.set('n', '<leader>fR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
vim.keymap.set('n', '<leader>tn', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })
vim.keymap.set('n', '<leader>N', function()
  Snacks.win {
    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = 'yes',
      statuscolumn = ' ',
      conceallevel = 3,
    },
  }
end, { desc = 'Neovim News' })
