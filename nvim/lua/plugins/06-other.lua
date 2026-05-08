-- plugins/06-other.lua
return {
	-- Lua nvim
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Editing
	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-commentary" },
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- UI
	{
		"scrooloose/nerdtree",
		cmd = "NERDTreeToggle",
		keys = {
			{ "<leader>k", ":NERDTreeToggle<cr>", silent = true, desc = "Toggle NERDTree" },
			{ "<leader>ff", ":NERDTreeFind<cr>", silent = true, desc = "Find current file in NERDTree" },
		},
	},
	{
		-- The new 0.12+ community standard for installing parsers
		"romus204/tree-sitter-manager.nvim",
		config = function()
			require("tree-sitter-manager").setup({
				ensure_installed = {
					"javascript",
					"typescript",
					"tsx",
					"go",
					"rust",
					"hcl",
					"graphql",
					"c_sharp",
					"markdown",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"powershell",
				},
				auto_install = true, -- Auto-install missing parsers on buffer enter
			})

			-- Neovim 0.12 handles highlighting natively!
			-- We just need an autocommand to start it for every buffer.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(event)
					pcall(vim.treesitter.start, event.buf)
				end,
			})

			-- Tell Neovim to treat .cake files as C#
			vim.filetype.add({
				extension = {
					cake = "cs",
				},
			})
		end,
	},

	-- Utilities
	{ "ludovicchabant/vim-gutentags", event = "VimEnter" },
	{ "editorconfig/editorconfig-vim" },
	{ "tyru/open-browser.vim" },

	-- PlantUML
	{ "aklt/plantuml-syntax", ft = "plantuml" },
	{ "weirongxu/plantuml-previewer.vim", ft = "plantuml" },
}
