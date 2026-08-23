return {
	"mistweaverco/kulala.nvim",
	keys = {
		{ "<leader>ws", desc = "Send request" },
		{ "<leader>wa", desc = "Send all requests" },
		{ "<leader>wp", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>k",
		kulala_keymaps_prefix = "",
		kulala_core = { path = "/nix/store/lkcisib1ncjgiq2y8rip85xijz7bdkl3-kulala-core-0.13.0/bin/kulala-core" },
	},
}
