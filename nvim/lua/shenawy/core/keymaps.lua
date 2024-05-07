local map = vim.keymap.set

map("n", "<leader>sv", "<C-w>v")
map("n", "<leader>sh", "<C-w>s")
map("n", "<leader>se", "<C-w>=")
map("n", "<leader>sx", "<cmd>close<CR>")

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

map("n", "<leader>k", "<cmd>cprev<CR>zz")
map("n", "<leader>j", "<cmd>cnext<CR>zz")
map("n", "<leader>h", "<cmd>cfirst<CR>zz")
map("n", "<leader>l", "<cmd>clast<CR>zz")

map("n", "<ESC>", ":<bs>")

map("n", "<leader>w", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end)

map({ "n", "v", "o" }, "<leader>z", function()
	vim.cmd("normal %")
end)

map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")

vim.keymap.del("s", "L")
vim.keymap.del("s", "H")

map("n", "<leader>q", "<C-^>")

map("n", "<leader>c", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
