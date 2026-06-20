vim.pack.add({
  'https://github.com/rest-nvim/rest.nvim',
  'https://github.com/SanoLitch/rest-gen.nvim',
})

require('rest-nvim').setup()
require('rest-gen').setup()

vim.api.nvim_create_user_command('OASPick', function()
  local file = vim.fn.expand('%:p')
  if file == '' then
    print('No file open')
    return
  end
  local source = file
  if file:match('%.ya?ml$') then
    local tmp = '/tmp/oas-tmp.json'
    vim.fn.system('yq -o=json ' .. file .. ' > ' .. tmp)
    source = tmp
  end
  require('rest-gen.telescope').picker(source)
end, {})

vim.keymap.set('n', '<leader>hr', '<cmd>OASPick<CR>', { desc = 'Pick OAS endpoint' })
vim.keymap.set('n', '<leader>gr', '<cmd>Rest run<CR>', { desc = 'Run REST request' })
