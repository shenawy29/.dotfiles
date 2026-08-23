return {
	"kylechui/nvim-surround",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	config = function()
		require("nvim-surround").setup()
	end,
}
