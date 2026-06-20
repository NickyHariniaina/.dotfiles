local group = vim.api.nvim_create_augroup('TmuxStatus', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  callback = function()
    vim.fn.system('tmux set status off')
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = group,
  callback = function()
    vim.fn.system('tmux set status on')
  end,
})
