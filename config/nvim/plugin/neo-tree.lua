vim.pack.add({
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', name = 'neo-tree' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons', name = 'nvim-web-devicons' },
})

require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = true,
  },
  window = {
    position = 'left',
    width = 45,
  },
  git_status_async = true,
})

vim.keymap.set('n', '-', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' })
