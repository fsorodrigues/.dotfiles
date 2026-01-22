-- LUA
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- GO
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
	on_attach = function(_, bufnr)
		-- Enable organizing imports on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
					bufnr = bufnr,
				})
			end,
		})
	end,
})

vim.lsp.enable({
	"lua_ls",
	"gopls",
	"svelte",
	"tailwindcss",
	"pyright",
})
