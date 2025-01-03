return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = true,
	opts = {
		-- numhl = true,
		sign_priority = 0, -- higher than diagnostic, todo signs. lower than dapui breakpoint sign
	},
}

-- return {
--     {
--         'echasnovski/mini.diff',
--         version = false,
--         config = function()
--             require('mini.diff').setup()
--         end
--     },
-- }
