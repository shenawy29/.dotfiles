return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"onsails/lspkind.nvim",
			"xzbdmw/colorful-menu.nvim",
			config = function()
				require("colorful-menu").setup({})
			end,
		},

		"junkblocker/blink-cmp-wezterm",
	},
	version = "1.*",
	config = function()
		require("blink.cmp").setup({
			keymap = {
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				-- ["<Tab>"] = {
				-- 	function(cmp)
				-- 		if cmp.snippet_active() then
				-- 			return cmp.snippet_forward()
				-- 		end
				--
				-- 		return cmp.select_next()
				-- 	end,
				-- 	"snippet_forward",
				-- 	"fallback",
				-- },
				-- ["<S-Tab>"] = {
				-- 	function(cmp)
				-- 		if cmp.snippet_active() then
				-- 			return cmp.snippet_backward()
				-- 		end
				--
				-- 		return cmp.select_prev()
				-- 	end,
				-- 	"snippet_backward",
				-- 	"fallback",
				-- },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-j>"] = { "select_next", "fallback_to_mappings" },
				["<C-k>"] = { "select_prev", "fallback_to_mappings" },

				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },

				["<C-x>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"wezterm",
					"omni",
				},
				providers = {
					wezterm = {
						module = "blink-cmp-wezterm",
						name = "wezterm",
						opts = {
							all_panes = false,
							capture_history = false,
							triggered_only = false,
							trigger_chars = { "." },
						},
					},
				},
			},

			cmdline = {
				keymap = {
					preset = "cmdline",
					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
				},
				completion = {
					list = {
						selection = {
							preselect = false,
						},
					},
					menu = {
						auto_show = true,
					},
				},
			},
			completion = {
				trigger = {
					show_in_snippet = true,
				},

				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
					},
				},
				menu = {
					border = "rounded",
					auto_show = true,
					-- cmdline_position = function()
					-- 	if vim.g.ui_cmdline_pos ~= nil then
					-- 		local pos = vim.g.ui_cmdline_pos
					-- 		return { pos[1] - 1, pos[2] }
					-- 	end
					-- 	local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					-- 	return { vim.o.lines - height, 0 }
					-- end,

					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },

						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 250,
					treesitter_highlighting = true,
					window = {
						border = "rounded",
					},
				},

				ghost_text = { enabled = true },
			},
		})

		-- vim.cmd("highlight! link BlinkCmpMenu NormalFloat")
		-- vim.cmd("highlight! link BlinkCmpMenuBorder NormalFloat")
	end,
	opts_extend = { "sources.default" },
}
