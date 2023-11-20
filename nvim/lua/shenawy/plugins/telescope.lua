return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("projects")
    -- require("telescope").extensions.projects.projects({})

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
    keymap.set("n", "<leader>pg", "<cmd>Telescope git_files<cr>")
    keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")
    keymap.set("n", "<leader>pc", "<cmd>Telescope grep_string<cr>")
    keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
    keymap.set("n", "<leader>ph", "<cmd>Telescope help_tags<cr>")
  end,
}
