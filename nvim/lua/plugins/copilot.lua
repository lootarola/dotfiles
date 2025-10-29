return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false,
        },
      },
      filetypes = {
        markdown = true,
        yaml = true,
        ['.'] = true,
      },
    }
    
    vim.keymap.set('i', '<Right>', function()
      local copilot_status = require('copilot.suggestion')
      if copilot_status.is_visible() then
        copilot_status.accept()
      else
        return '<Right>'
      end
    end, {
      expr = true,
      desc = 'Accept Copilot Suggestion',
    })
  end,
}
