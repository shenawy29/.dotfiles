return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		vim.diagnostic.config({
			signs = true,
			virtual_text = {
				source = "if_many",
				prefix = "● ",
			},
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "if_many",
				header = "",
				prefix = "",
			},
		})

		local lspconfig = require("lspconfig")

		local opts = {
			servers = {
				basedpyright = {},
				prismals = {},
				svelte = {},
				sqls = {},
				gopls = {},
				phpactor = {},
				cmake = {},
				templ = {},
				clangd = {},
				tailwindcss = {},
				cssls = {},
				jsonls = {},
				bashls = {},
				ocamllsp = {},
				lua_ls = {},
				dartls = {},
				hls = {},
				ts_ls = {},
				omnisharp = {},
				zls = {},
				dockerls = {},
				html = {},
				nil_ls = {},
			},
		}

		vim.g.zig_fmt_parse_errors = 0

		for server, config in pairs(opts.servers) do
			local capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			config.capabilities = capabilities
			lspconfig[server].setup(config)
		end

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
