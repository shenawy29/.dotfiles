-- Lazy
return {
	"dlyongemallo/diffview-plus.nvim",
	dependencies = {
		"rickhowe/diffchar.vim",
		config = function()
			vim.g.DiffDelPosVisible = 1
			vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewToggle<CR>")

			vim.cmd([[
      nmap <leader>g <Nop>
      nmap <leader>p <Nop>
    ]])

			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
				keymaps = {
					view = {
						["q"] = "<Cmd>DiffviewClose<CR>",
					},
				},
				view = {
					["q"] = "<Cmd>DiffviewClose<CR>",
					-- default = { layout = "diff2_horizontal" },
					merge_tool = { layout = "diff3_horizontal" },
					cycle_layouts = {
						default = { "diff2_horizontal", "diff1_inline" },
					},

					default = { layout = "diff1_inline" },
					inline = { style = "overleaf" },
				},
				file_panel = {
					listing_style = "tree",
					win_config = { position = "left", width = 35 },
				},
				hooks = {},
			})
		end,
	},
}
