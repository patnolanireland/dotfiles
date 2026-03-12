-- This function will run for *every* LSP server that attaches
local function on_attach(client, bufnr)
	-- Set up keymaps only for this buffer
	local opts = { buffer = bufnr, noremap = true, silent = true }

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '[d', function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, opts)

	-- Jump to next diagnostic
	vim.keymap.set('n', ']d', function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, opts)
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

-- Create an autocommand group for LSP configuration
local lsp_augroup = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

-- Attach the `on_attach` function to the LspAttach event
vim.api.nvim_create_autocmd('LspAttach', {
	group = lsp_augroup,
	callback = function(args)
		-- `args.buf` is the buffer number
		-- `args.data.client_id` is the client ID
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		on_attach(client, args.buf)
	end,
	desc = "Apply keymaps and settings on LSP attach"
})

vim.g.auto_save = 1

vim.g.auto_save_in_insert_mode = 0

local function SaveIfUnsaved()
	if vim.opt.modified:get() then
		vim.cmd('silent! w')
	end
end

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	pattern = "*",
	callback = SaveIfUnsaved,
	desc = "Save if unsaved on focus lost/buffer leave",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	callback = function() vim.cmd('silent! checktime') end,
	desc = "Read file on focus/buffer enter",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "plantuml",
	callback = function()
		local plantuml_jar_cmd_output = vim.fn.system('cat `which plantuml` | grep plantuml.jar')
		local plantuml_regex_pattern = [[\v.*\s['"]?(\S+plantuml\.jar).*]]
		local match_result = vim.fn.matchlist(plantuml_jar_cmd_output, plantuml_regex_pattern)
		local jar_path = match_result[2]

		-- WSL2 / Ubuntu Fallback
		if not jar_path or jar_path == "" then
			if vim.fn.filereadable("/usr/share/plantuml/plantuml.jar") == 1 then
				jar_path = "/usr/share/plantuml/plantuml.jar"
			end
		end

		vim.g.plantuml_previewer_plantuml_jar_path = jar_path or 0
	end,
	desc = "Set PlantUML JAR path",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	callback = function() vim.opt_local.textwidth = 80 end,
	desc = "Set textwidth for Markdown files",
})
