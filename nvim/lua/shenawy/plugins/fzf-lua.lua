return {
	"ibhagwan/fzf-lua",
	-- lazy = true,
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-treesitter/nvim-treesitter-context",
	},
	keys = {
		{
			"<leader>fo",
			"<cmd>lua require('fzf-lua').oldfiles()<cr>",
		},
		{
			"<leader>ff",
			"<cmd>lua require('fzf-lua').files()<cr>",
		},
		{
			"<leader>fg",
			"<cmd>lua require('fzf-lua').git_files()<cr>",
		},
		{
			"<leader>fs",
			"<cmd>lua require('fzf-lua').live_grep()<cr>",
		},
		{
			"<leader>fc",
			"<cmd>lua require('fzf-lua').grep_cword()<cr>",
		},
		{
			"<leader>fh",
			"<cmd>lua require('fzf-lua').helptags()<cr>",
		},
		{
			"<leader>fb",
			"<cmd>lua require('fzf-lua').buffers()<cr>",
		},
		{
			"<leader>vca",
			"<cmd>lua require('fzf-lua').lsp_code_actions()<cr>",
		},
	},
	config = function()
		require("fzf-lua").setup({
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
			},
		})
	end,
}
