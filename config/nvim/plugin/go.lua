vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'go.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('go.nvim') end
      vim.cmd('lua require("go.install").update_all_sync()')
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/ray-x/go.nvim', name = 'go.nvim' },
  { src = 'https://github.com/ray-x/guihua.lua', name = 'guihua' },
})

require('go').setup({})

local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})
