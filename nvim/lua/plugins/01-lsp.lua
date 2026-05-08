-- plugins/01-lsp.lua
return {
	-- 1. Core Mason package manager
	{
		"williamboman/mason.nvim",
		opts = {}, -- Lazy automatically calls require("mason").setup(opts)
	},

	-- 2. Automate formatters and linters (Replaces your broken mason.setup array)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
			},
		},
	},

	-- 3. LSP Configurations
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/lazydev.nvim",
		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_lsp.default_capabilities()

			-- Setup mason-lspconfig with the new API
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"omnisharp",
					"pyright",
					"gopls",
					"intelephense",
					"powershell_es",
				},
				handlers = {
					-- Default handler for all servers
					function(server_name)
						vim.lsp.config(server_name, {
							capabilities = capabilities,
						})
					end,

					-- Do NOT set up rust_analyzer (rustaceanvim handles it)
					["rust_analyzer"] = function() end,

					-- Custom config for pyright
					["pyright"] = function()
						vim.lsp.config("pyright", {
							capabilities = capabilities,
							settings = {
								python = { pythonPath = vim.fn.exepath("python") },
							},
						})
					end,

					-- Custom config for lua_ls
					["lua_ls"] = function()
						vim.lsp.config("lua_ls", {
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- Completion Engine (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Better UI for completion
	{ "stevearc/dressing.nvim" },

	-- Lua development helper
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
