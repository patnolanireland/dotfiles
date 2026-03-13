-- core/ftdetect.lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tsx",
  command = "set filetype=typescriptreact",
})
