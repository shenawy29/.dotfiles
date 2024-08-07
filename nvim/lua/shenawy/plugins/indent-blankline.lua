return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		scope = { enabled = false, show_start = false, show_end = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	},
	main = "ibl",
}
