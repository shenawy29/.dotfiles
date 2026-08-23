return {
	"nvim-mini/mini.operators",
	event = { "InsertEnter" },
	version = false,
	config = function()
		require("mini.operators").setup()
	end,
}
