vim.pack.add({
  { src = 'https://github.com/ThePrimeagen/harpoon', name = 'harpoon', version = 'harpoon2' },
})

local harpoon = require('harpoon')
harpoon:setup({
  global_settings = {
    save_on_change = true,
    excluded_filetypes = { 'harpoon' },
    mark_branch = false,
  },
})

local function toggle_telescope(harpoon_files)
  local conf = require('telescope.config').values
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require('telescope.pickers').new({}, {
    prompt_title = 'Harpoon',
    finder = require('telescope.finders').new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<C-e>', function()
  toggle_telescope(harpoon:list())
end, { desc = 'Open harpoon window' })
vim.keymap.set('n', '<C-j>', function()
  harpoon:list():prev()
end, { desc = 'Harpoon: previous mark' })
vim.keymap.set('n', '<C-k>', function()
  harpoon:list():next()
end, { desc = 'Harpoon: next mark' })
vim.keymap.set('n', '<leader>rm', function()
  harpoon:list():remove()
end, { desc = 'Harpoon: remove current' })

harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set('n', '<C-v>', function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr, desc = 'Open in vertical split' })
    vim.keymap.set('n', '<C-x>', function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr, desc = 'Open in horizontal split' })
    vim.keymap.set('n', '<C-t>', function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr, desc = 'Open in new tab' })
  end,
})
