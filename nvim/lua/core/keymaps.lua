vim.keymap.set("i", "jk", "<Esc>", { desc = "Remap jk to Escape" })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set("n", "<CR>", ":noh<CR><CR>", { desc = "Clear search highlight on Enter" })
vim.keymap.set("n", "K", ":grep! '\\b<C-R><C-W>\\b'<CR>:cw<CR>", { desc = "Grep word under cursor" })
