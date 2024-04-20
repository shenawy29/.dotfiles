return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local clients_lsp = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.buf_get_clients(bufnr)
      if next(clients) == nil then
        return ""
      end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, client.name)
      end
      return "\u{f085} " .. table.concat(c, "|")
    end

    local branch = { "branch", icon = "" }
    local mode = { "mode", icon = "" }
    local diagnostics = {
      "diagnostics",
      symbols = {
        error = " ",
        warn = " ",
        info = " ",
      },
      colored = true,
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        component_separators = {},
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, "harpoon2", { "filename", path = 1 } },
        lualine_c = {},
        lualine_x = { diagnostics, "diff", "filetype" },
        lualine_y = { "progress", "location" },
        lualine_z = { clients_lsp },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
