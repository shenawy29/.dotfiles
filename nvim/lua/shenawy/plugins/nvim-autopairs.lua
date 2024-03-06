return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    local ts_conds = require("nvim-autopairs.ts-conds")

    npairs.setup({ check_ts = true })

    npairs.add_rules({
      Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    })
  end,
}
