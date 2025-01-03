return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	lazy = true,
	keys = {
		{ "<leader>cp", "<cmd>CompetiTest receive problem<CR>" },
		{ "<leader>cc", "<cmd>CompetiTest receive contest<CR>" },
		{ "<leader>ct", "<cmd>CompetiTest receive testcases<CR>" },
		{ "<leader>cr", "<cmd>CompetiTest run<CR>" },
	},
	config = function()
		require("competitest").setup()
	end,
}
