return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = false,
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },

  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
    },
    {
      "<leader>fg",
      "<cmd>Telescope git_files<cr>",
    },
    {
      "<leader>fs",
      "<cmd>Telescope live_grep<cr>",
    },
    {
      "<leader>fc",
      "<cmd>Telescope grep_string<cr>",
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
    },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          initial_mode = "normal",
        },
      },
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },

          n = {
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        file_browser = {
          auto_depth = true,
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
