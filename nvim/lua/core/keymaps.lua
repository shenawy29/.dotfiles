local map = vim.keymap.set

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
	clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

map("n", "<leader>\\", "<C-w>v")
map("n", "<leader>-", "<C-w>s")
map("n", "<leader>=", "<C-w>=")

map("x", "@", function()
	return ":norm @" .. vim.fn.getcharstr() .. "<cr>"
end, { expr = true })

map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

map("v", "<S-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<S-k>", ":m '<-2<CR>gv=gv", { silent = true })

map("c", "<C-h>", "<Left>")
map("c", "<C-k>", "<Up>")
map("c", "<C-j>", "<Down>")
map("c", "<C-l>", "<Right>")
map("c", "<C-u>", "<S-Left>")
map("c", "<C-d>", "<S-Right>")

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("i", "<C-d>", "<C-d>zz")

map("n", "<leader><leader>", function()
	vim.cmd("w")
end)

map({ "n", "x", "o" }, "<C-Space>", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

map({ "n", "x", "o" }, "<BS>", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

map({ "n", "i" }, "<F2>", function()
	if vim.bo.keymap == "" then
		vim.o.keymap = "arabic"
		vim.o.rightleft = true

		vim.keymap.set({ "n", "v", "o" }, "L", "^", { buffer = true })
		vim.keymap.set({ "n", "v", "o" }, "H", "$", { buffer = true })
	else
		vim.o.keymap = ""
		vim.o.rightleft = false
		vim.keymap.set({ "n", "v", "o" }, "H", "^", { buffer = true })
		vim.keymap.set({ "n", "v", "o" }, "L", "$", { buffer = true })
	end
end)

map({ "n", "v", "o" }, "<S-z>", function()
	vim.cmd("normal %")
end)

map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")

vim.keymap.del("s", "L")
vim.keymap.del("s", "H")

map("n", "<leader>q", "<C-^>")

local opts = { noremap = true, silent = true }

map("n", "<leader>r", function()
	vim.lsp.buf.rename()
end, opts)

map("n", "<leader>vd", function()
	vim.diagnostic.open_float({ focusable = true })
end, opts)

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, opts)

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, opts)

map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")

vim.keymap.set("n", "k", function()
	return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })

vim.keymap.set("n", "j", function()
	return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })
