-- plugins/04-telescope.lua
return {
    { 'nvim-lua/plenary.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- This build command now runs in the correct plugin directory
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release'
            }
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup({
                -- your telescope config here
            })
            -- Load fzf-native
            telescope.load_extension('fzf')
        end,
        keys = {
            { "<C-p>",           "<cmd>Telescope find_files<cr>", desc = "Fuzzy Find Files" },
            { "<leader>gf",      "<cmd>Telescope git_files<cr>",  desc = "Fuzzy Find Git Files" },
            { "<leader>fg",      "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
            { "<leader><SPACE>", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
            { "<leader>fb",      "<cmd>Telescope buffers<cr>",    desc = "Telescope Buffers" },
            { "<leader>fh",      "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
        }
    },
}
