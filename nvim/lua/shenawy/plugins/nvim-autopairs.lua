return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter" },
	branch = "v0.6",
	opts = {
		pair_cmap = false,
	},
}
-- return {
--     "windwp/nvim-autopairs",
--     event = "InsertEnter",
--     -- config = true
--     config = function()
--         local npairs = require("nvim-autopairs")
--         local Rule = require('nvim-autopairs.rule')
--
--         npairs.setup({
--             check_ts = true,
--         })
--
--         local ts_conds = require('nvim-autopairs.ts-conds')
--
--         npairs.add_rules({
--             Rule("%", "%", "lua")
--                 :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
--             Rule("$", "$", "lua")
--                 :with_pair(ts_conds.is_not_ts_node({ 'function' }))
--         })
--     end
-- }
