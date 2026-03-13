-- core/options.lua
vim.opt.syntax = "on"
vim.opt.ruler = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cmdheight = 2
vim.opt.hidden = true
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.encoding = "utf8"
vim.opt.clipboard = "unnamedplus"
vim.opt.diffopt:append("vertical")
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.tabstop = 5
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.splitright = true
vim.opt.statusline = "%F"
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
