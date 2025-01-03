vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "qf,help,neotest-output",
	callback = function()
		vim.keymap.set("n", "q", "<C-w>c", { buffer = true })
	end,
})
