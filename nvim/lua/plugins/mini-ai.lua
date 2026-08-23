return {
	"nvim-mini/mini.ai",
	event = { "InsertEnter" },
	version = false,
	config = function()
		require("mini.ai").setup()
	end,
}
