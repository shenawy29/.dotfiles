return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			html = { "prettierd" },
			mdx = { "prettierd" },
			css = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			svelte = { "prettierd" },
			markdown = { "prettierd" },
			astro = { "prettierd" },
			graphql = { "prettierd" },
			rust = { "rustfmt" },
			python = { "ruff_format" },
			nix = { "nixfmt" },
			lua = { "stylua" },
			sh = { "shfmt" },
			ocaml = { "ocamlformat" },
			-- cmake = { "cmakelang" },
			asm = { "asmfmt" },
		},

		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
