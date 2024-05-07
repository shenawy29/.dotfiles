return {
	lazy = true,
	"debugloop/telescope-undo.nvim",
	keys = {
		{
			"<leader>u",
			"<cmd>Telescope undo<cr>",
			desc = "undo history",
		},
	},
	opts = {
		extensions = {
			undo = {},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("undo")
	end,
}
