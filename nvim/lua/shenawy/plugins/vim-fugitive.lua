return {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	"tpope/vim-fugitive",
	keys = {
		{
			"<leader>gs",
			"<cmd>Git<cr>",
		},
		{
			"<leader>i",
			"<cmd>Git add .<cr>",
		},
	},
}
