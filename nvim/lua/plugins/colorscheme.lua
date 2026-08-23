return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme

				return {

					rainbow1fg = { fg = "#E46876" },
					rainbow2fg = { fg = "#FFA066" },
					rainbow3fg = { fg = "#C8C093" },
					rainbow4fg = { fg = "#98BB6C" },
					rainbow5fg = { fg = "#7FB4CA" },
					rainbow6fg = { fg = "#9CABCA" },

					rainbow1 = { fg = "#E46876", bg = "#2A2A37" },
					rainbow2 = { fg = "#FFA066", bg = "#2A2A37" },
					rainbow3 = { fg = "#C8C093", bg = "#2A2A37" },
					rainbow4 = { fg = "#98BB6C", bg = "#2A2A37" },
					rainbow5 = { fg = "#7FB4CA", bg = "#2A2A37" },
					rainbow6 = { fg = "#9CABCA", bg = "#2A2A37" },

					SnacksNotifierBorderError = { link = "DiagnosticError" },
					SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
					SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
					SnacksNotifierBorderDebug = { link = "Debug" },
					SnacksNotifierBorderTrace = { link = "Comment" },
					SnacksNotifierIconError = { link = "DiagnosticError" },
					SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
					SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
					SnacksNotifierIconDebug = { link = "Debug" },
					SnacksNotifierIconTrace = { link = "Comment" },
					SnacksNotifierTitleError = { link = "DiagnosticError" },
					SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
					SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
					SnacksNotifierTitleDebug = { link = "Debug" },
					SnacksNotifierTitleTrace = { link = "Comment" },
					SnacksNotifierError = { link = "DiagnosticError" },
					SnacksNotifierWarn = { link = "DiagnosticWarn" },
					SnacksNotifierInfo = { link = "DiagnosticInfo" },
					SnacksNotifierDebug = { link = "Debug" },
					SnacksNotifierTrace = { link = "Comment" },
					-- SnacksProfiler
					SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
					SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
					SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
					SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
					SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
					SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
					SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
					SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
					SnacksZenIcon = { fg = theme.syn.statement },
					SnacksInputIcon = { fg = theme.ui.pmenu.bg },
					SnacksInputBorder = { fg = theme.syn.identifier },
					SnacksInputTitle = { fg = theme.syn.identifier },
					-- SnacksPicker
					SnacksPickerInputBorder = { fg = theme.syn.constant },
					SnacksPickerInputTitle = { fg = theme.syn.constant },
					SnacksPickerBoxTitle = { fg = theme.syn.constant },
					SnacksPickerSelected = { fg = theme.syn.number },
					SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
					SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
					SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },

					-- Blink
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					BlinkCmpDocSeparator = { link = "Pmenu" },
					BlinkCmpMenu = { link = "Pmenu" },
					BlinkCmpMenuSelection = { link = "PmenuThumb" },
					BlinkCmpMenuBorder = { link = "Pmenu" },
					BlinkCmpDoc = { link = "Pmenu" },
					BlinkCmpDocBorder = { link = "Pmenu" },
					BlinkCmpDocCursorLine = { link = "Pmenu" },
					BlinkCmpSignatureHelp = { link = "Pmenu" },
					BlinkCmpSignatureHelpBorder = { link = "Pmenu" },

					-- MarkView
					MarkviewHeading1 = { link = "rainbow1" },
					MarkviewHeading1Sign = { link = "rainbow1" },
					MarkviewHeading2 = { link = "rainbow2" },
					MarkviewHeading2Sign = { link = "rainbow2" },
					MarkviewHeading3 = { link = "rainbow3" },
					MarkviewHeading4 = { link = "rainbow4" },
					MarkviewHeading5 = { link = "rainbow5" },
					MarkviewHeading6 = { link = "rainbow6" },
					MarkviewBlockQuoteError = { link = "rainbow1fg" },
					MarkviewBlockQuoteNote = { link = "rainbow5fg" },
					MarkviewBlockQuoteOk = { link = "rainbow4fg" },
					MarkviewBlockQuoteSpecial = { link = "rainbow3fg" },
					MarkviewBlockQuoteWarn = { link = "rainbow2fg" },
					MarkviewCheckboxChecked = { link = "rainbow4fg" },
					MarkviewCheckboxPending = { link = "rainbow2fg" },
					MarkviewCheckboxProgress = { link = "rainbow6fg" },
					MarkviewCheckboxUnchecked = { link = "rainbow1fg" },
				}
			end,
		})

		vim.cmd([[colorscheme kanagawa-wave]])
	end,
}
