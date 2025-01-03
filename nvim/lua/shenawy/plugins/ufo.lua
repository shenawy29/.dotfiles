return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	-- event = { "BufReadPre", "BufNewFile", "BufEnter" },
	config = function()
		-- vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		--
		-- capabilities.textDocument.foldingRange = {
		-- 	dynamicRegistration = false,
		-- 	lineFoldingOnly = true,
		-- }

		-- local language_servers = require("lspconfig").util.available_servers()
		-- for _, ls in ipairs(language_servers) do
		-- 	require("lspconfig")[ls].setup({
		-- 		capabilities = capabilities,
		-- 	})
		-- end

		require("ufo").setup()

		-- Option 3: treesitter as a main provider instead
		-- (Note: the `nvim-treesitter` plugin is *not* needed.)
		-- ufo uses the same query files for folding (queries/<lang>/folds.scm)
		-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
		-- require('ufo').setup({
		--     provider_selector = function(bufnr, filetype, buftype)
		--         return { 'treesitter', 'indent' }
		--     end
		-- })
		--
	end,
}
