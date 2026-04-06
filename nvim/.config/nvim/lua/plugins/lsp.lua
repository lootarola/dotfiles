require('fidget').setup {}
require('lazydev').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func)
      vim.keymap.set('n', keys, func, { buffer = event.buf })
    end

    map('<leader>llr', vim.lsp.buf.rename)
    map('<leader>lla', vim.lsp.buf.code_action)
    map('K', vim.lsp.buf.hover)

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
  bashls = {},
  cssls = {},
  harper_ls = {},
  gopls = {},
  html = {},
  marksman = {},
  groovyls = {},
  pyright = {},
  rust_analyzer = {},
  sqls = {},
  ts_ls = {},
  docker_compose_language_service = {},
  dockerls = {},
  jsonls = {},
  yamlls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}

require('mason').setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
  'markdownlint',
  'prettier',
})

require('mason-lspconfig').setup {
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- conform.nvim
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    json = { 'prettier' },
    go = { 'gofmt', 'goimports' },
  },
}
vim.keymap.set('n', '<leader>bf', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format' })

-- otter.nvim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'yaml',
  callback = function()
    require('otter').activate({ 'bash' }, true, true, nil)
  end,
})

-- nvim-lint
local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    require('lint').try_lint()
  end,
})
