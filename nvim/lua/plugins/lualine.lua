return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local clients_lsp = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = bufnr })

			if next(clients) == nil then
				return ""
			end

			local c = {}
			for _, client in pairs(clients) do
				table.insert(c, client.name)
			end
			return "\u{f085}  " .. table.concat(c, "|")
		end

		local branch = { "branch", icon = "" }
		local mode = { "mode", icon = "" }
		local diagnostics = {
			"diagnostics",
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
			},
			colored = true,
		}

		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = {
					branch,
					"harpoon2",
					{
						"filename",
						path = 1,
					},
					"%S",

					-- { require("recorder").recordingStatus },
					-- {
					-- 	function()
					-- 		local reg = vim.fn.reg_recording()
					-- 		if reg == "" then
					-- 			return " "
					-- 		end -- not recording
					-- 		return "recording to " .. reg
					-- 	end,
					-- },
				},

				lualine_c = {
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = {
							fg = "#FF9E3B",
						},
					},
				},

				lualine_x = {
					diagnostics,
					"diff",
					{
						"filetype",
						colored = true,
						icon_only = true,
					},
				},
				lualine_y = { "progress", "location" },
				lualine_z = { clients_lsp },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
