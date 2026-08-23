return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>,",
			function()
				require("treesj").toggle()
			end,
		},
	},
	config = function()
		require("treesj").setup({ use_default_keymaps = false })
	end,
}
