vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "qf,help,neotest-output,gitsigns-blame,fugitiveblame,fugitive,dap-view,dap-view-term,dap-repl",
	callback = function()
		vim.keymap.set("n", "q", "<C-w>c", { buffer = true })
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "DiffviewFiles",
	callback = function()
		vim.keymap.set("n", "q", "<cmd>tabclose<CR>", { buffer = true })
	end,
})
