return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		dependencies = {
			{
				{ "OXY2DEV/markview.nvim" },
			},
		},
		init = function()
			local ensureInstalled = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"cpp",
				"c",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			require("nvim-treesitter").install(parsersToInstall)
		end,
	},

	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false,
	-- 	opts = {
	-- 		preview = {
	-- 			modes = { "n", "no", "c", "i" },
	-- 			linewise_hybrid_mode = true,
	-- 			hybrid_modes = { "i", "n" },
	-- 			icon_provider = "mini",
	-- 		},
	-- 	},
	--
	-- 	priority = 49,
	-- },

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
		end,
	},
}
