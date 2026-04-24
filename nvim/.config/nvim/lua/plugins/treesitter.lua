vim.g.no_plugin_maps = true

require('nvim-treesitter.install').prefer_git = true

require('nvim-treesitter').install {
  'bash',
  'css',
  'csv',
  'diff',
  'dockerfile',
  'gitignore',
  'go',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'sql',
  'tsv',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if ev.match == 'html' then
      return
    end
    pcall(vim.treesitter.start, ev.buf)
  end,
})
