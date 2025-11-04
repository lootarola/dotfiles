return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = {
          function(cmp)
            local copilot = require 'copilot.suggestion'
            if copilot.is_visible() then
              copilot.accept()
              return
            else
              return cmp.accept()
            end
          end,
          'fallback',
        },
        ['<C-n>'] = {
          function(cmp)
            local copilot = require 'copilot.suggestion'
            if copilot.is_visible() then
              copilot.next()
              return
            else
              return cmp.select_next()
            end
          end,
          'fallback',
        },
        ['<C-p>'] = {
          function(cmp)
            local copilot = require 'copilot.suggestion'
            if copilot.is_visible() then
              copilot.prev()
              return
            else
              cmp.select_prev()
              return
            end
          end,
          'fallback',
        },
        ['<C-e>'] = {
          function(cmp)
            local copilot = require 'copilot.suggestion'
            if copilot.is_visible() then
              copilot.dismiss()
              return
            else
              return cmp.hide()
            end
          end,
          'fallback',
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = false,
          auto_update = false,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
