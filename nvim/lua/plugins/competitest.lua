return {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	lazy = true,
	keys = {
		{ "<leader>cp", "<cmd>CompetiTest receive problem<CR>" },
		{ "<leader>cc", "<cmd>CompetiTest receive contest<CR>" },
		{ "<leader>ct", "<cmd>CompetiTest receive testcases<CR>" },
		{ "<leader>cr", "<cmd>CompetiTest run<CR>" },
	},
	config = function()
		require("competitest").setup({
			received_problems_path = "/home/shenawy/projects/problems/$(PROBLEM).$(FEXT)",
			compile_command = {
				cpp = {
					exec = "g++",
					args = {
						"-Wall",
						"-g",
						"-fsanitize=address",
						"-fsanitize=undefined",
						"-fno-omit-frame-pointer",
						"-rdynamic",
						"$(FNAME)",
						"-o",
						"$(FNOEXT)",
					},
				},
			},

			run_command = {
				cpp = {
					exec = "sh",
					args = {
						"-c",
						-- symbolize=1: ensures you get line numbers
						-- strip_path_prefix: removes the long /nix/store/... and /home/shenawy/... junk
						-- fast_unwind_on_malloc=0: gives more accurate stack traces in some environments
						'ASAN_OPTIONS=symbolize=1:strip_path_prefix=/home/shenawy/projects/:handle_abort=1:detect_leaks=0 "./$(FNOEXT)"',
					},
				},
			},
		})
	end,
}
