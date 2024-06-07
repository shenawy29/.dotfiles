return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>n",
			function()
				require("treesj").toggle({
					split = {
						recursive = true,
					},
				})
			end,
		},
	},
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})
	end,
}
