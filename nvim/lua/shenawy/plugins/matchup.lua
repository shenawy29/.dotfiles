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

		require("nvim-treesitter.configs").setup({
			matchup = {
				enable = true,
			},
		})

		-- local ok, cmp = pcall(require, "cmp")

		-- if ok then
		--     cmp.event:on("menu_opened", function() vim.b.matchup_matchparen_enabled = false end)
		--     cmp.event:on("menu_closed", function() vim.b.matchup_matchparen_enabled = true end)
		-- end
		require("match-up").setup(opts)
	end,
}
