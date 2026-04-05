require('blink.cmp').setup {
  keymap = {
    preset = 'default',
    ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-e>'] = { 'hide', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = {
      auto_show = false,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
