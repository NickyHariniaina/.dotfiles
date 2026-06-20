vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope.nvim', name = 'telescope' },
  { src = 'https://github.com/folke/todo-comments.nvim', name = 'todo-comments' },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', function()
  builtin.find_files({
    hidden = false,
    no_ignore = false,
  })
end, {})
vim.keymap.set('n', '<leader>pws', function()
  builtin.live_grep()
end, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    path_display = { 'smart' },
    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
})

require('todo-comments').setup({})

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next Todo Comment' })
vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous Todo Comment' })
vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = 'Todo' })
vim.keymap.set('n', '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', { desc = 'Todo/Fix/Fixme' })
