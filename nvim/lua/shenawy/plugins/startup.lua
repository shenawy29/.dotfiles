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
          { " File Browser", "Oil", "-" },
          { " Find File", "Telescope find_files", "<leader>ff" },
          { " New File", "lua require'startup'.new_file()", "<leader>nf" },
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
