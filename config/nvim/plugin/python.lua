vim.pack.add({
  { src = 'https://github.com/mfussenegger/nvim-dap-python', name = 'dap-python' },
})

require('dap-python').setup('python3')
