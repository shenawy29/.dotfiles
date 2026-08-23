return {
	"mfussenegger/nvim-dap",
	event = "LspAttach",
	dependencies = {
		"igorlfs/nvim-dap-view",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"mxsdev/nvim-dap-vscode-js",
		{
			"mfussenegger/nvim-dap-python",
			event = "LspAttach",
		},
	},
	config = function(opts)
		local dap = require("dap")

		dap.defaults.auto_continue_if_many_stopped = false

		local js = vim.fn.getenv("JS_DEBUG")

		-- Continue
		_G._dap_continue = function()
			dap.continue()
		end

		vim.keymap.set("n", "<leader>dc", function()
			vim.o.operatorfunc = "v:lua._dap_continue"
			vim.cmd.normal("g@l")
		end)

		-- Toggle Breakpoint
		_G._dap_toggle = function()
			dap.toggle_breakpoint()
		end

		vim.keymap.set("n", "<leader>db", function()
			vim.o.operatorfunc = "v:lua._dap_toggle"
			vim.cmd.normal("g@l")
		end)

		-- Step Into
		_G._dap_step_into = function()
			dap.step_into()
		end

		vim.keymap.set("n", "<leader>di", function()
			vim.o.operatorfunc = "v:lua._dap_step_into"
			vim.cmd.normal("g@l")
		end)

		-- Step Over
		_G._dap_step_over = function()
			dap.step_over()
		end

		vim.keymap.set("n", "<leader>do", function()
			vim.o.operatorfunc = "v:lua._dap_step_over"
			vim.cmd.normal("g@l")
		end)

		-- Step Out
		_G._dap_step_out = function()
			dap.step_out()
		end

		vim.keymap.set("n", "<leader>dO", function()
			vim.o.operatorfunc = "v:lua._dap_step_out"
			vim.cmd.normal("g@l")
		end)

		-- local dap_icons = {
		-- 	Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		-- 	Breakpoint = " ",
		-- 	BreakpointCondition = " ",
		-- 	BreakpointRejected = { " ", "DiagnosticError" },
		-- 	LogPoint = ".>",
		-- }

		-- for name, sign in pairs(dap_icons) do
		-- 	sign = type(sign) == "table" and sign or { sign }
		-- 	vim.fn.sign_define(
		-- 		"Dap" .. name,
		-- 		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
		-- 	)
		-- end

		dap.adapters.codelldb = function(cb, config)
			if config.preLaunchTask then
				vim.fn.system(config.preLaunchTask)
			end

			cb({
				type = "server",
				port = "${port}",
				options = {
					initialize_timeout_sec = 30,
				},
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			})
		end

		dap.configurations.cpp = {
			{
				name = "CP",
				type = "codelldb",
				request = "launch",
				preLaunchTask = function()
					return "g++ -g -fsanitize=address -O0 -o '"
						.. vim.fn.expand("%:r")
						.. "' '"
						.. vim.fn.expand("%")
						.. "'"
				end,
				program = function()
					return vim.fn.expand("%:r")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				stdio = {
					function()
						return coroutine.create(function(coro)
							vim.cmd("echohl Question")
							vim.cmd('echon "Test input index: "')
							vim.cmd("echohl None")

							local ch = vim.fn.getchar()
							local idx = "0"

							if type(ch) == "number" then
								local char = vim.fn.nr2char(ch)
								if char ~= "\r" and char ~= "\n" and char:match("%d") then
									idx = char
								end
							end

							local base = vim.fn.expand("%:r")
							local input = base .. "_input" .. idx .. ".txt"
							local output = base .. "_output" .. idx .. ".txt"
							local error = base .. "_error" .. idx .. ".txt"

							coroutine.resume(coro, input, output, error)
						end)
					end,
					nil,
					nil,
				},
			},

			{
				name = "CMake",
				type = "codelldb",
				request = "launch",
				preLaunchTask = function()
					return "cmake --build build"
				end,
				program = function()
					return coroutine.create(function(coro)
						vim.ui.input({
							prompt = "Executable name (in build/): ",
						}, function(input)
							coroutine.resume(coro, "build/" .. input)
						end)
					end)
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},

			{
				name = "Build & run current file",
				type = "codelldb",
				request = "launch",
				preLaunchTask = function()
					return "g++ -g -fsanitize=address -O0 -o '"
						.. vim.fn.expand("%:r")
						.. "' '"
						.. vim.fn.expand("%")
						.. "'"
				end,
				program = function()
					return vim.fn.expand("%:r")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,

				args = function()
					return coroutine.create(function(coro)
						vim.ui.input({
							prompt = "Args: ",
						}, function(input)
							local parsed = {}
							if input and input ~= "" then
								parsed = vim.split(input, " ")
							end
							coroutine.resume(coro, parsed)
						end)
					end)
				end,
			},
		}

		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				preLaunchTask = function()
					return "gcc -g -o " .. "'" .. vim.fn.expand("%:r") .. "'" .. " " .. "'" .. vim.fn.expand("%") .. "'"
				end,
				program = function()
					return vim.fn.expand("%:r")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		local dapui = require("dap-view")

		dapui.setup({
			winbar = {
				show = true,
				-- You can add a "console" section to merge the terminal with the other views
				sections = { "console", "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
				default_section = "scopes",
				controls = { enabled = true },
			},
		})
		require("nvim-dap-virtual-text").setup()

		dap.listeners.before.attach["dap-view-config"] = function()
			dapui.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dapui.close()
		end

		local python = vim.fn.getenv("NVIM_PYTHON_PATH") .. "/bin/python3"

		local adapters = {
			"chrome",
			"pwa-node",
			"pwa-chrome",
			"pwa-msedge",
			"pwa-extensionHost",
			"node-terminal",
		}

		-- require("dap-vscode-js").setup({
		-- 	debugger_path = js,
		-- 	adapters = adapters,
		-- })

		for _, adapter in ipairs(adapters) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = js .. "/bin/js-debug",
					args = {
						"${port}",
					},
				},

				smartStep = true,

				skipFiles = {
					"<node_internals>/**",
					"${workspaceFolder}/node_modules/**/*.js",
				},
			}
		end

		local js_based_languages = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"vue",
		}

		for _, language in ipairs(js_based_languages) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					executable = {
						command = js .. "/bin/js-debug",
					},

					-- processId = require("dap.utils").pick_process,

					skipFiles = {
						"<node_internals>/**",
						"${workspaceFolder}/node_modules/**/*.js",
					},

					smartStep = true,
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					smartStep = true,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,

					executable = {
						command = js .. "/bin/js-debug",
					},

					skipFiles = {
						"<node_internals>/**",
						"${workspaceFolder}/node_modules/**/*.js",
					},

					console = "integratedTerminal",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				{
					name = "----- ↓ launch.json configs ↓ -----",
					type = "",
					request = "launch",
				},
			}
		end

		require("dap-go").setup()
		require("dap-python").setup(python)
	end,
}
