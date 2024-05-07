return {
	{
		"nvim-neorg/neorg",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"vhyrro/luarocks.nvim",
				lazy = true,
				event = { "BufReadPre", "BufNewFile" },
				priority = 1000,
				config = true,
			},
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			})
		end,
	},
}
