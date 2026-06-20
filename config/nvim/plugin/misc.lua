vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'swagger-preview' and (kind == 'install' or kind == 'update') then
      vim.fn.system('npm i')
    end
  end,
})

local orig_notify = vim.notify
vim.notify = function(msg, level, ...)
  if level == vim.log.levels.ERROR then return end
  return orig_notify(msg, level, ...)
end

vim.pack.add({
  'https://github.com/rest-nvim/rest.nvim',
  { src = 'https://github.com/vinnymeller/swagger-preview.nvim', name = 'swagger-preview' },
  'https://github.com/laytan/cloak.nvim',
  'https://github.com/olrtg/nvim-emmet',
  { src = 'https://github.com/kawre/leetcode.nvim', name = 'leetcode' },
  { src = 'https://github.com/MunifTanjim/nui.nvim', name = 'nui' },
  'https://github.com/sotte/presenting.nvim',
  { src = 'https://github.com/nickjvandyke/opencode.nvim', name = 'opencode' },
})

vim.notify = orig_notify

vim.o.autoread = true
vim.g.opencode_opts = {}

vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,       { desc = "Select OpenCode…" })
vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Append range to OpenCode", expr = true })
vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })

package.loaded['mimetypes'] = nil
require('rest-nvim').setup({})

require('cloak').setup({
  enabled = true,
  cloak_character = '*',
  highlight_group = 'Comment',
  patterns = {
    {
      file_pattern = {
        '.env*',
        'wrangler.toml',
        '.dev.vars',
        'application.properties',
      },
      cloak_pattern = '=.+',
    },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)

require('leetcode').setup({})

require('presenting').setup({
  options = {
    width = 80,
  },
})
