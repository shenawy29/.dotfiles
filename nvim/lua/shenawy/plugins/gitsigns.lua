return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = true,
	opts = {
		-- numhl = true,
		sign_priority = 15, -- higher than diagnostic, todo signs. lower than dapui breakpoint sign
	},
}
