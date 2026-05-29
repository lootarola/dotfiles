local M = {}

function M.navigate(dir)
  local win = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. dir)
  if vim.api.nvim_get_current_win() == win then
    local t = { h = 'L', j = 'D', k = 'U', l = 'R' }
    vim.fn.system('tmux select-pane -' .. t[dir])
  end
end

return M
