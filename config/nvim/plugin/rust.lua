vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'cargo' and (kind == 'install' or kind == 'update') then
      vim.fn.system('cargo build --release')
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/mrcjkb/rustaceanvim', name = 'rustaceanvim', version = vim.version.range('^6') },
  { src = 'https://github.com/nwiizo/cargo.nvim', name = 'cargo' },
  { src = 'https://github.com/saecki/crates.nvim', name = 'crates' },
})

local cargo_dir = vim.fn.stdpath('data') .. '/site/pack/core/opt/cargo'
if vim.fn.isdirectory(cargo_dir .. '/target/release') == 0 then
  local cwd = vim.uv.cwd()
  vim.uv.chdir(cargo_dir)
  vim.fn.system('cargo build --release')
  vim.uv.chdir(cwd)
end

require('cargo').setup({
  float_window = true,
  window_width = 0.8,
  window_height = 0.8,
  border = 'rounded',
})

require('crates').setup()
