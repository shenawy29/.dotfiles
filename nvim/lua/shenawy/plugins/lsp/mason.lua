return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile", "CmdlineEnter" },
	lazy = true,
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			cmd = { "LspInstall", "LspUninstall" },
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
		},
		{
			"mfussenegger/nvim-dap",
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		{
			"rcarriga/nvim-dap-ui",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-nvim-dap").setup({
			ensure_installed = { "python", "delve" },
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>ds", dap.continue)
		vim.keymap.set("n", "<leader>dn", dap.step_into)
		vim.keymap.set("n", "<leader>dq", dap.terminate)

		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason_lspconfig.setup({
			ensure_installed = {
				"asm_lsp",
				"bashls",
				"clangd",
				"cssls",
				"docker_compose_language_service",
				"dockerls",
				"gopls",
				"graphql",
				"jdtls",
				"jsonls",
				"lua_ls",
				"ocamllsp",
				"omnisharp",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				"tsserver",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"prettierd",
				"ocamlformat",
				"eslint_d",
				"cmakelang",
			},
		})
	end,
}
