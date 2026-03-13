-- plugins/02-rust.lua
return {
	{
		'mrcjkb/rustaceanvim',
		version = '^6',
		lazy = false,     -- This plugin is already lazy
		-- No config needed! It will auto-detect nvim-dap and codelldb.
	},
	{
		'saecki/crates.nvim',
		ft = { 'toml' },
		config = function()
			require('crates').setup({})
		end
	},
}
