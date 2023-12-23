local opt = vim.opt

opt.guicursor = ""

vim.g.mapleader = " "

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

opt.nu = true
opt.relativenumber = true

-- opt.fillchars = { eob = " " }

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
-- opt.isfname:append("@-@")

opt.updatetime = 50

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.backspace = "indent,eol,start"

-- opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true
