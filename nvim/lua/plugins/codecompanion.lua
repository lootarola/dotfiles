return {
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'j-hui/fidget.nvim',
      {
        'ravitemer/mcphub.nvim',
        cmd = 'MCPHub',
        build = 'npm install -g mcp-hub@latest',
        config = true,
      },
    },
    opts = {
      strategies = {
        chat = {
          keymaps = {
            send = {
              modes = { n = '<CR>', i = '<C-s>' },
            },
          },
          opts = {
            completion_provider = 'cmp',
          },
          adapter = {
            name = 'copilot',
            model = 'claude-3.7-sonnet',
          },
        },
        inline = {
          adapter = {
            name = 'copilot',
            model = 'gpt-4.1',
          },
        },
      },
      display = {
        action_palette = {
          provider = 'default',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
        diff = {
          provider = 'mini_diff',
        },
      },
    },
    init = function()
      require('plugins.codecompanion.fidget-spinner'):init()
    end,
  },
}
