return {
	"nvim-neotest/neotest",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-python",
		{
			"mrcjkb/rustaceanvim",
			version = "^5",
			-- lazy = false,
			ft = "rust",
		},
	},

	config = function()
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>mr", ':lua require("neotest").run.run()<CR>', opts)
		vim.keymap.set("n", "<leader>ms", ':lua require("neotest").run.stop()<CR>', opts)
		vim.keymap.set("n", "<leader>mo", ':lua require("neotest").output.open()<CR>', opts)
		vim.keymap.set("n", "<leader>mt", ':lua require("neotest").summary.toggle()<CR>', opts)
		vim.keymap.set("n", "<leader>ma", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
		vim.keymap.set("n", "[m", ':lua require("neotest").jump.prev()<CR>', opts)
		vim.keymap.set("n", "]m", ':lua require("neotest").jump.next()<CR>', opts)

		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
				require("neotest-go"),
				require("neotest-python"),
			},
		})
	end,
}
