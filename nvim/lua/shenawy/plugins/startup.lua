return {
	"startup-nvim/startup.nvim",
	config = function()
		require("startup").setup({
			header = {
				type = "text",
				align = "center",
				title = "Header",
				content = {
					"             ...::::...                                ",
					"     .-=*#@@@@@@@@@@@@@@@@%#*=-.                       ",
					" .=#@@@%#*=-::..     ..::-=+*%@@@*=:                   ",
					" #%+=:                         :=*%@@%*=:              ",
					"                                   .-=*%@@%#*+==---::: ",
					"            ::-----::.                   .:--=++******.",
					"       .+#@@@@@@@@@@@@@@#*=:                           ",
					"      +@%+*@@@@@@@@@@@@::=+#@%+-                       ",
					"    :%@-  *@@@@@@@@@@@@:     -%@@#*=--::...            ",
					"  .*@*    .@@@@@@@@@@@#     :*@@%###%%%@@@@@@@@@@@%%%# ",
					".+@@+-::...:#@@@@@@@@#-=+*%%#+-.                ..:::: ",
					"=*++++*@@@@@@@@@@@@%#*+=-:                             ",
					"       -@@@@**@@@@#.                                   ",
					"       -@@@@-  -#@@@*:                           .:.   ",
					"       *@@@@-    .+%@@%=.                      :*-:-*= ",
					"      -@@@@@.       .+%@@#=.                   *-:=+ #.",
					"       *@@@#           .=*@@%+:                 =--: #:",
					"        @@@+               :+#@@#=:                 +* ",
					"        +@@+                   :+#@@#+-:.       :-*#-  ",
					"        .@@=                       .:=*##%%%###*+-     ",
					"         -+.                                           ",
				},

				highlight = "Statement",
			},

			body = {
				type = "mapping",
				align = "center",
				title = "Basic Commands",
				content = {
					{ "  File Browser", "Oil", "-" },
					{ "  Find File", "lua require'fzf-lua'.files()", "<leader>ff" },
					{ "  Find Word", "lua require'fzf-lua'.live_grep()", "<leader>fs" },
					{ "  Recent Files", "lua require'fzf-lua'.oldfiles()", "<leader>fo" },
				},
				highlight = "String",
			},
			footer = {
				type = "text",
				align = "center",
				title = "Footer",
				content = { "carpe diem, quam minimum credula postero." },
				highlight = "Number",
			},

			options = {
				mapping_keys = true,
				cursor_column = 0.5,
				empty_lines_between_mappings = true,
				disable_statuslines = false,
				paddings = { 3, 3, 3 },
			},
			parts = { "header", "body", "footer" },
		})
	end,
}
