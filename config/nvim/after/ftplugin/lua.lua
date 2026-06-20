local cmp = require("cmp")
cmp.setup.buffer({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>pi", function()
	local inspect = require("plenary.inspect")
	local line = vim.api.nvim_get_current_line()
	print(inspect(load("return " .. line)()))
end, opts)

-- Test unitaires rapides
vim.keymap.set("n", "<leader>tt", function()
	require("plenary.test_harness").test_directory("tests/")
end, opts)

vim.keymap.set("n", "<leader>ts", function()
  vim.cmd("PlenaryBustedFile %")
end)
