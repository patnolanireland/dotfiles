return {
	-- Editing
	{ 'tpope/vim-unimpaired' },
	{ 'tpope/vim-commentary' },
	{ "kylechui/nvim-surround", config = function() require("nvim-surround").setup({}) end },

	-- UI
	{
		'scrooloose/nerdtree',
		cmd = 'NERDTreeToggle',
		keys = {
			{ "<leader>k",  ":NERDTreeToggle<cr>", silent = true, desc = "Toggle NERDTree" },
			{ "<leader>ff", ":NERDTreeFind<cr>",   silent = true, desc = "Find current file in NERDTree" },
		}
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					"javascript", "typescript", "tsx", "go",
					"rust", "hcl", "graphql", "c_sharp"
				},
				-- These fields satisfy the lua_ls 'missing-fields' warning
				sync_install = false,
				auto_install = true,     -- Automatically install missing parsers when entering buffer
				ignore_install = {},
				modules = {},

				highlight = { enable = true },
			})

			-- Tell Neovim to treat .cake files as C# so treesitter applies the syntax
			vim.filetype.add({
				extension = {
					cake = 'cs',
				}
			})
		end
	},

	-- Utilities
	{ 'ludovicchabant/vim-gutentags',     event = 'VimEnter' },
	{ 'editorconfig/editorconfig-vim' },
	{ 'tyru/open-browser.vim' },

	-- PlantUML
	{ 'aklt/plantuml-syntax',             ft = 'plantuml' },
	{ 'weirongxu/plantuml-previewer.vim', ft = 'plantuml' },
}
