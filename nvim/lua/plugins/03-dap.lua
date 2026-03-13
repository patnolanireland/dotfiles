-- plugins/03-dap.lua
return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- This bridge plugin is what reads the 'ensure_installed'
            {
                "jay-babu/mason-nvim-dap.nvim",
                config = function()
                    require("mason-nvim-dap").setup({
                        -- This is where you list debuggers for Mason to install
                        ensure_installed = { "codelldb" }
                    })
                end
            },
        },
        config = function()
            -- Your DAP listener config (which is correct)
            local dap, dapui = require('dap'), require('dapui')
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- Your keymaps are here now
            vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Debugger step into" })
            vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Debugger step over" })
            vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Debugger step out" })
            vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Debugger step continue" })
            vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
                { desc = "Debugger step toggle breakpoint" })
            vim.keymap.set("n", "<leader>dd",
                "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
                { desc = "Debugger set conditional breakpoint" })
            vim.keymap.set("n", "<leader>de", "<cmd>lua require'dap'.terminate()<cr>", { desc = "Debugger reset" })
            vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.last_run()<cr>", { desc = "Debugger run last" })
            vim.keymap.set("n", "<leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<cr>",
                { desc = "Debugger testables" })
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require('dapui').setup()
        end
    },
}
