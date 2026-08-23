return {
	"jake-stewart/multicursor.nvim",
	event = { "BufReadPre", "BufNewFile" },
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		set("n", "<c-leftmouse>", mc.handleMouse)
		set("n", "<c-leftdrag>", mc.handleMouseDrag)
		set("n", "<c-leftrelease>", mc.handleMouseRelease)

		set({ "n", "x" }, "<leader>k", function()
			mc.lineAddCursor(-1)
		end)
		set({ "n", "x" }, "<leader>j", function()
			mc.lineAddCursor(1)
		end)
		set({ "n", "x" }, "<leader>K", function()
			mc.lineSkipCursor(-1)
		end)
		set({ "n", "x" }, "<leader>J", function()
			mc.lineSkipCursor(1)
		end)

		set({ "n", "x" }, "<leader>n", function()
			mc.matchAddCursor(1)
		end)
		set({ "n", "x" }, "<leader>ss", function()
			mc.matchSkipCursor(1)
		end)
		set({ "n", "x" }, "<leader>N", function()
			mc.matchAddCursor(-1)
		end)
		set({ "n", "x" }, "<leader>S", function()
			mc.matchSkipCursor(-1)
		end)

		set({ "n", "x" }, "mw", function()
			mc.operator({ motion = "iw", visual = true })
		end)
		set("n", "<leader>m", mc.operator)

		set("x", "M", mc.matchCursors)

		set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

		set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			end
		end)

		set("n", "<leader>cb", mc.restoreCursors)

		set("x", "I", mc.insertVisual)
		set("x", "A", mc.appendVisual)

		set({ "x", "n" }, "<c-i>", mc.jumpForward)
		set({ "x", "n" }, "<c-o>", mc.jumpBackward)

		set("n", "<leader>/n", function()
			mc.searchAddCursor(1)
		end)
		set("n", "<leader>/N", function()
			mc.searchAddCursor(-1)
		end)

		set("n", "<leader>/s", function()
			mc.searchSkipCursor(1)
		end)
		set("n", "<leader>/S", function()
			mc.searchSkipCursor(-1)
		end)

		set("n", "<leader>/A", mc.searchAllAddCursors)

		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
