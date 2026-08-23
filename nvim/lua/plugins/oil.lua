return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{ "-", "<cmd>Oil<cr>" },
	},
	dependencies = {
		{
			"benomahony/oil-git.nvim",
			dependencies = { "stevearc/oil.nvim" },
		},
		{
			"JezerM/oil-lsp-diagnostics.nvim",
			dependencies = { "stevearc/oil.nvim" },
			opts = {},
		},
	},
	config = function()
		local detail = false
		require("oil").setup({
			use_default_keymaps = false,
			keymaps = {
				["gd"] = {
					desc = "Toggle file detail view",
					callback = function()
						detail = not detail
						if detail then
							require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
						else
							require("oil").set_columns({ "icon" })
						end
					end,
				},

				["g?"] = "actions.show_help",
				["<Tab>"] = "actions.select",
				["<CR>"] = "actions.select",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-g>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		})
	end,
}

-- return {
-- 	"A7Lavinraj/fyler.nvim",
-- 	dependencies = { "nvim-mini/mini.icons" },
-- 	-- lazy = false,
-- 	keys = {
-- 		{ "-", "<cmd>Fyler<cr>" },
-- 	},
-- 	opts = {
-- 		mappings = {
-- 			["q"] = "CloseView",
-- 			["<Tab>"] = "Select",
-- 			["<C-t>"] = "SelectTab",
-- 			-- ["\\"] = "SelectVSplit",
-- 			-- ["0"] = "SelectSplit",
-- 			["-"] = "GotoParent",
-- 			["="] = "GotoCwd",
-- 			["."] = "GotoNode",
-- 		},
-- 		-- views = {
-- 		-- 	confirm = {
-- 		-- 		win = {
-- 		-- 			-- Changes window border
-- 		-- 			border = "single",
-- 		-- 			-- Changes buffer options
-- 		-- 			buf_opts = {
-- 		-- 				-- buffer options
-- 		-- 			},
-- 		-- 			-- Changes window kind
-- 		-- 			kind = "float",
-- 		-- 			-- Changes window kind preset
-- 		-- 			kind_presets = {
-- 		-- 				-- values can be "(0,1]rel" or "{1...}abs"
-- 		--
-- 		-- 				-- <preset_name> = {
-- 		-- 				--   height = "",
-- 		-- 				--   width = "",
-- 		-- 				--   top = "",
-- 		-- 				--   left = ""
-- 		-- 				-- }
-- 		--
-- 		-- 				-- float = {
-- 		-- 				--   height = "0.3rel",
-- 		-- 				--   width = "0.4rel",
-- 		-- 				--   top = "0.3rel",
-- 		-- 				--   left = "0.3rel"
-- 		-- 				-- },
-- 		-- 			},
-- 		-- 			-- Changes window options
-- 		-- 			win_opts = {
-- 		-- 				-- window options
-- 		-- 			},
-- 		-- 		},
-- 		-- 	},
-- 		-- 	explorer = {
-- 		-- 		-- Changes explorer closing behaviour when a file get selected
-- 		-- 		close_on_select = true,
-- 		-- 		-- Changes explorer behaviour to auto confirm simple edits
-- 		-- 		confirm_simple = false,
-- 		-- 		-- Changes explorer behaviour to hijack NETRW
-- 		-- 		default_explorer = true,
-- 		-- 	},
-- 		-- },
-- 	},
-- }
-- return {
-- 	"A7Lavinraj/fyler.nvim",
-- 	dependencies = { "nvim-mini/mini.icons" },
-- 	lazy = false,
-- 	keys = {
-- 		{ "-", "<cmd>Fyler<cr>" },
-- 	},
-- 	opts = {
-- 		views = {
-- 			finder = {
-- 				mappings = {
-- 					["q"] = "CloseView",
-- 					["<CR>"] = "Select",
-- 					["<C-t>"] = "SelectTab",
-- 					["<leader>\\"] = "SelectVSplit",
-- 					["<leader>-"] = "SelectSplit",
-- 					["-"] = "GotoParent",
-- 					["="] = "GotoCwd",
-- 					["<Tab>"] = "GotoNode",
-- 					["#"] = "CollapseAll",
-- 					["<BS>"] = "CollapseNode",
-- 				},
-- 				win = {
-- 					win_opts = {
-- 						number = true,
-- 						relativenumber = true,
-- 					},
-- 				},
-- 			},
-- 		},
-- 	},
-- }
