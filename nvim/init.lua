-- ============================================================================

-- Neovim Configuration: init.lua
-- ============================================================================

-- Global options
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = ","
vim.g.maplocalleader = ","
-- Disable unused providers to speed up startup and silence checkhealth
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
	----------------------------------------------------------------------------
	-- VS Code Neovim Configuration
	-- (This section is unchanged from your original file)
	----------------------------------------------------------------------------
	require("lazy").setup({
		{
			"kylechui/nvim-surround",
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
	})
	local vscode = require("vscode")
	vim.keymap.set({ "n", "x" }, "<leader>rn", function()
		vscode.action("editor.action.rename")
	end, { desc = "Rename Symbol (VS Code)" })
	vim.keymap.set({ "n", "x" }, "<leader> ", function()
		vscode.action("workbench.action.findInFiles")
	end, { desc = "Find in Files (VS Code)" })
	vim.keymap.set("n", "gd", function()
		vscode.action("editor.action.revealDefinition")
	end, { desc = "Go to Definition (VS Code)" })
	vim.keymap.set("n", "gy", function()
		vscode.action("editor.action.goToTypeDefinition")
	end, { desc = "Go to Type Definition (VS Code)" })
	vim.keymap.set("n", "gi", function()
		vscode.action("editor.action.goToImplementation")
	end, { desc = "Go to Implementation (VS Code)" })
	vim.keymap.set("n", "gr", function()
		vscode.action("editor.action.findAllReferences")
	end, { desc = "Find All References (VS Code)" })
	vim.keymap.set("n", "K", function()
		vscode.action("editor.action.showHover")
	end, { desc = "Show Hover (VS Code)" })
	vim.keymap.set({ "n", "x" }, "<leader>f", function()
		vscode.action("editor.action.formatDocument")
	end, { desc = "Format Document (VS Code)" })
	vim.keymap.set({ "n", "x" }, "<leader>a", function()
		vscode.action("editor.action.codeAction")
	end, { desc = "Code Action (VS Code)" })
	vim.keymap.set("n", "<leader>ac", function()
		vscode.action("editor.action.codeAction")
	end, { desc = "Code Action (VS Code)" })
	vim.keymap.set("n", "<leader>qf", function()
		vscode.action("editor.action.fixAll")
	end, { desc = "Fix All (VS Code)" })
	vim.keymap.set("n", "<leader>k", function()
		vscode.action("workbench.files.action.focusFilesExplorer")
	end, { desc = "Focus File Explorer (VS Code)" })
	vim.keymap.set("n", "<leader>ff", function()
		vscode.action("workbench.files.action.focusFilesExplorer")
	end, { desc = "Find in File Explorer (VS Code)" })
	vim.keymap.set("n", "<C-p>", function()
		vscode.action("workbench.action.quickOpen")
	end, { desc = "Quick Open (VS Code)" })
else
	----------------------------------------------------------------------------
	-- Standalone Neovim Configuration
	----------------------------------------------------------------------------

	-- Load core settings
	require("core.options")
	require("core.ftdetect")
	require("core.keymaps")
	require("core.autocmds")

	-- Setup lazy.nvim to load all plugins from the `lua/plugins/` directory
	require("lazy").setup("plugins", {
		-- You can add lazy.nvim options here if needed
	})

	-- Other global settings
	vim.g.perl_host_prog = vim.fn.exepath("perl")
	vim.g.latex_to_unicode_tab = 0
	vim.g.prettier_config_trailing_comma = "all"
	vim.g.terraform_align = 1
	vim.g.terraform_fmt_on_save = 1
	vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
	vim.g.NERDTreeIgnore = { "tags" }
end
