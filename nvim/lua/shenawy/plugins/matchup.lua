return {
  "andymass/vim-matchup",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.g.matchup_matchparen_offscreen = {
      scrolloff = 1,
    }
    require("nvim-treesitter.configs").setup({
      matchup = {
        enable = true,
      },
    })
  end,
}
