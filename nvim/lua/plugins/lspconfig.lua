return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/neoconf.nvim",
			config = function()
				require("neoconf").setup()
			end,
		},

	},

	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.lsp.config("neocmake", {
			capabilities = capabilities,
		})
	end,
}
