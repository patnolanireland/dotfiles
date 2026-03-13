-- plugins/05-git.lua
return {
    {
        'tpope/vim-fugitive',
        cmd = { "G", "Git", "Gblame", "Gdiffsplit", "Gclog" },
        keys = {
            { '<leader>gh', '<cmd>0Gclog<CR>', desc = 'Git History', silent = true },
            { "<leader>gl", ":0Gclog<cr>",     silent = true,        desc = "Git Log (Fugitive)" },
        }
    },
    { 'tpope/vim-rhubarb' },
    {
        'APZelos/blamer.nvim',
        ft = { 'gitcommit', 'gitrebase', 'diff', 'lua', 'vim' },
        keys = {
            { "<leader>bt", ":BlamerToggle<cr>", silent = true, desc = "Toggle Blamer" }
        }
    },
}
