return {
  "echasnovski/mini.indentscope",
  version = false,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  config = function()
    local indentscope = require("mini.indentscope")
    indentscope.setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = indentscope.gen_animation.none(),
      },
    })
  end,
}

-- return {
--   "echasnovski/mini.indentscope",
-- }
