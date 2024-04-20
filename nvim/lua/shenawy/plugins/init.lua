return {
  { "nvim-lua/plenary.nvim" },

  "christoomey/vim-tmux-navigator",

  {
    "inkarkat/vim-ReplaceWithRegister",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
}
