return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{ "<leader>b", "<cmd>require('dap').toggle_breakpoint()<CR>" },
		{ "<leader>b", "<cmd>require('dap').run_to_cursor()<CR>" },
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")
		require("nvim-dap-virtual-text").setup()
		ui.setup()

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
