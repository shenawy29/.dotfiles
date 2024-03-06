function ColorMyPencils()
  vim.cmd("hi SignColumn guibg=NONE")
  vim.opt.fillchars = { eob = " " }
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
