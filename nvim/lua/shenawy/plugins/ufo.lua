return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldtext = ""
		vim.opt.fillchars:append("fold: ")
		vim.opt.foldlevelstart = 99

		require("ufo").setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		})
	end,
}
