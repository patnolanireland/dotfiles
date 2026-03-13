-- plugins/00-theme.lua
return {
    {
        'overcache/NeoSolarized',
        priority = 1000, -- Make sure this loads first
        config = function()
            -- Set the colorscheme and background
            vim.opt.background = "dark"
            vim.cmd("colorscheme NeoSolarized")
        end
    },
    {
        'vim-airline/vim-airline',
        -- Make sure themes are loaded with airline
        dependencies = { 'vim-airline-themes' }
    },
    {
        'vim-airline/vim-airline-themes',
        -- Configure airline *after* it has loaded
        config = function()
            vim.g.airline_solarized_bg = 'dark'
        end
    },
}
