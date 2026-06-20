vim.pack.add({
  'https://github.com/tpope/vim-fugitive',
  { src = 'https://github.com/lewis6991/gitsigns.nvim', name = 'gitsigns' },
  { src = 'https://github.com/ldelossa/gh.nvim', name = 'gh' },
  { src = 'https://github.com/ldelossa/litee.nvim', name = 'litee' },
  { src = 'https://github.com/kdheepak/lazygit.nvim', name = 'lazygit' },
})



vim.keymap.set('n', '<leader>b', '<cmd>Git branch<CR>', { desc = 'List and switch branches' })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = '[G]it [B]lame' })
vim.keymap.set('n', 'gu', '<cmd>diffget //2<cr>')
vim.keymap.set('n', 'gh', '<cmd>diffget //3<cr>')
vim.keymap.set('n', '<leader>gs', '<cmd>vertical Git<CR>', { desc = 'Open git tab for interaction' })
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open lazygit' })

local nicky_group = vim.api.nvim_create_augroup('nicky_group', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = nicky_group,
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', '<leader>p', function()
      vim.cmd.Git('push')
    end, opts)

    vim.keymap.set('n', '<leader>P', function()
      vim.cmd.Git({ 'pull', '--rebase' })
    end, opts)
  end,
})

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    map('n', ']h', gs.next_hunk, 'Next Hunk')
    map('n', '[h', gs.prev_hunk, 'Prev Hunk')

    map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
    map('v', '<leader>hs', function()
      gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Stage hunk')
    map('v', '<leader>hr', function()
      gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Reset hunk')

    map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
    map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')

    map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')

    map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')

    map('n', '<leader>hb', function()
      gs.blame_line({ full = true })
    end, 'Blame line')
    map('n', '<leader>hB', gs.toggle_current_line_blame, 'Toggle line blame')

    map('n', '<leader>hd', gs.diffthis, 'Diff this')
    map('n', '<leader>hD', function()
      gs.diffthis('~')
    end, 'Diff this ~')

    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Gitsigns select hunk')
  end,

  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  signs_staged = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
  },
  current_line_blame = true,
})

require('litee.lib').setup()
require('litee.gh').setup()
