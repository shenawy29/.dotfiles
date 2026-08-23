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
			version = "^9",
			lazy = false,

			-- https://github.com/MaxKiv/dotfiles/blob/fc0340fbf935bea7ea0814dca9674ec44ad29459/.config/nvim/lua/plugins/rustaceanvim.lua#L15
			config = function()
				local cfg = require("rustaceanvim.config")

				local extension_path = nil
				local codelldb_path = nil
				local liblldb_path = nil

				extension_path = vim.fn.getenv("NVIM_CODELLDB_PATH")

				if not extension_path or extension_path == vim.NIL or extension_path == "" then
					-- vim.notify(
					-- 	"Running NixOS but NVIM_CODELLDB_PATH is not set. Please configure the environment variable.",
					-- 	vim.log.levels.ERROR
					-- )
					return
				end

				codelldb_path = extension_path .. "/adapter/codelldb"
				liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

				vim.g.rustaceanvim = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				}
			end,
		},
	},

	config = function()
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>ts", ':lua require("neotest").run.run()<CR>', opts)
		-- vim.keymap.set("n", "<leader>ts", ':lua require("neotest").run.stop()<CR>', opts)
		vim.keymap.set("n", "<leader>to", ':lua require("neotest").output.open()<CR>', opts)
		vim.keymap.set("n", "<leader>tt", ':lua require("neotest").summary.toggle()<CR>', opts)
		vim.keymap.set("n", "<leader>ta", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
		vim.keymap.set("n", "[T", ':lua require("neotest").jump.prev()<CR>', opts)
		vim.keymap.set("n", "]T", ':lua require("neotest").jump.next()<CR>', opts)

		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
				require("neotest-go"),
				require("neotest-python"),
			},
		})
	end,
}
