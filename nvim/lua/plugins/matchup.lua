return {
	"andymass/vim-matchup",
	enabled = true,
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function(_, opts)
		vim.g.matchup_matchparen_offscreen = {
			scrolloff = 1,
		}

		vim.g.matchup_matchparen_pumvisible = 0

		-- require("nvim-treesitter.configs").setup({
		-- 	matchup = {
		-- 		enable = true,
		-- 	},
		-- })
		require("match-up").setup(opts)
	end,
}
