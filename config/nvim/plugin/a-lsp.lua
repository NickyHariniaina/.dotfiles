vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/nvim-cmp',
  { src = 'https://github.com/L3MON4D3/LuaSnip', name = 'LuaSnip', version = vim.version.range('v2.*') },
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/petertriho/cmp-git',
  'https://github.com/davidsierradz/cmp-conventionalcommits',
  { src = 'https://github.com/supermaven-inc/supermaven-nvim', name = 'supermaven' },
})

local ls = require('luasnip')
ls.filetype_extend('javascript', { 'jsdoc' })

vim.keymap.set({ 'i' }, '<C-s>e', function()
  ls.expand()
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-s>;', function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-s>,', function()
  ls.jump(-1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

require('conform').setup({
  formatters_by_ft = {
    c = { 'clang' },
    cpp = { 'ast-grep' },
    lua = { 'stylua' },
    go = { 'gofumpt' },
    python = { 'ruff_format' },
    javascriptreact = { 'biome' },
    javascript = { 'biome' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
    rust = { 'rustfmt' },
  },
})

require('lint').linters_by_ft = {
  typescript = { 'eslint_d' },
  javascript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  sql = { 'postgrestools' },
  json = { 'json' },
  rust = { 'ast-grep' },
  java = { 'ast-grep' },
  css = { 'ast-grep' },
  html = { 'ast-grep' },
  openapi = { 'vacuum' },
  python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = vim.tbl_deep_extend(
  'force',
  {},
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities()
)

require('fidget').setup({})
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      vim.lsp.config[server_name].setup({
        capabilities = capabilities,
      })
    end,


    zls = function()
      vim.lsp.config.zls.setup({
        root_markers = { '.git', 'build.zig', 'zls.json' },
        settings = {
          zls = {
            enable_inlay_hints = true,
            enable_snippets = true,
            warn_style = true,
          },
        },
      })
      vim.g.zig_fmt_parse_errors = 0
      vim.g.zig_fmt_autosave = 0
    end,

    ['lua_ls'] = function()
      vim.lsp.config.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = { 'vim' },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = 'space',
                indent_size = '2',
              },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = { enable = false },
          },
        },
      })
    end,

    ['tailwindcss'] = function()
      vim.lsp.config.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = {
          'html',
          'css',
          'scss',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
          'svelte',
          'heex',
        },
      })
    end,

    ['basedpyright'] = function()
      vim.lsp.config.basedpyright.setup({
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
              autoImportCompletions = true,
            },
          },
        },
      })
    end,
  },
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  performance = {
    debounce = 60,
    throttle = 30,
    max_view_entries = 20,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-@>'] = cmp.mapping.complete(),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'supermaven' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

require('supermaven-nvim').setup({})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})


table.insert(require('cmp').get_config().sources, { name = 'git' })
