vim.api.nvim_create_user_command('OASPreview', function()
  local file = vim.fn.expand('%:p')
  if file == '' then
    print('No file open')
    return
  end
  local out = '/tmp/openapi-preview.html'
  vim.fn.system('npx @redocly/cli build-docs ' .. file .. ' -o ' .. out)
  vim.fn.system('xdg-open ' .. out)
  print('OpenAPI preview generated')
end, {})
