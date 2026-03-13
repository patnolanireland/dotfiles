-- plugins/07-formatting.lua
return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- Run formatter before saving
        cmd = "ConformInfo",
        opts = {
            -- Set up formatters
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt" },

                -- Use Prettier for all these filetypes
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                html = { "prettier" },
                vue = { "prettier" },
                markdown = { "prettier" },
                yaml = { "prettier" },
                graphql = { "prettier" },
            },
            -- This will run formatting on save
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true, -- Fallback to LSP formatting if conform fails
            },
        },
        -- Add keymaps for manual formatting
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
    },
}
